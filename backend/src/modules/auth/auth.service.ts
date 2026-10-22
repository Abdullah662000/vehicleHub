import {
  BadRequestException,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { JwtService } from '@nestjs/jwt';
import { InjectRepository } from '@nestjs/typeorm';
import * as bcrypt from 'bcrypt';
import { createHash, randomInt } from 'crypto';
import { Repository } from 'typeorm';
import { User } from '../users/entities/user.entity';
import { OtpCode } from './entities/otp-code.entity';
import { RefreshToken } from './entities/refresh-token.entity';
import {
  LoginDto,
  RefreshTokenDto,
  ResendOtpDto,
  SignupDto,
  VerifyOtpDto,
} from './dto/auth.dto';

@Injectable()
export class AuthService {
  constructor(
    @InjectRepository(User) private readonly usersRepo: Repository<User>,
    @InjectRepository(RefreshToken)
    private readonly refreshRepo: Repository<RefreshToken>,
    @InjectRepository(OtpCode) private readonly otpRepo: Repository<OtpCode>,
    private readonly jwt: JwtService,
    private readonly config: ConfigService,
  ) {}

  private toPublicUser(user: User) {
    return {
      id: user.id,
      fullName: user.fullName,
      email: user.email,
      phone: user.phone,
      avatarUrl: user.avatarUrl,
    };
  }

  private hashToken(token: string) {
    return createHash('sha256').update(token).digest('hex');
  }

  private hashOtp(phone: string, code: string) {
    const pepper = this.config.getOrThrow<string>('otp.pepper');
    return createHash('sha256')
      .update(`${pepper}:${phone}:${code}`)
      .digest('hex');
  }

  private async issueTokens(user: User) {
    const payload = { sub: user.id, email: user.email };
    const accessToken = await this.jwt.signAsync(payload, {
      secret: this.config.getOrThrow<string>('jwt.accessSecret'),
      expiresIn: this.config.get<string>('jwt.accessExpires') ?? '15m',
    } as Parameters<JwtService['signAsync']>[1]);
    const refreshToken = await this.jwt.signAsync(payload, {
      secret: this.config.getOrThrow<string>('jwt.refreshSecret'),
      expiresIn: this.config.get<string>('jwt.refreshExpires') ?? '7d',
    } as Parameters<JwtService['signAsync']>[1]);

    const decoded = this.jwt.decode(refreshToken) as { exp?: number };
    const expiresAt = new Date((decoded.exp ?? 0) * 1000);

    await this.refreshRepo.save(
      this.refreshRepo.create({
        userId: user.id,
        tokenHash: this.hashToken(refreshToken),
        expiresAt,
      }),
    );

    return { accessToken, refreshToken };
  }

  private async createAndStoreOtp(phone: string) {
    const code = String(randomInt(100000, 999999));
    const ttl = this.config.get<number>('otp.ttlSeconds') ?? 300;
    const expiresAt = new Date(Date.now() + ttl * 1000);

    await this.otpRepo
      .createQueryBuilder()
      .update(OtpCode)
      .set({ consumedAt: () => 'NOW()' })
      .where('phone = :phone AND consumed_at IS NULL', { phone })
      .execute();

    await this.otpRepo.save(
      this.otpRepo.create({
        phone,
        codeHash: this.hashOtp(phone, code),
        expiresAt,
      }),
    );

    if (this.config.get('nodeEnv') !== 'production') {
      // eslint-disable-next-line no-console
      console.log(`[OTP] ${phone} => ${code}`);
    }

    return code;
  }

  async signup(dto: SignupDto) {
    const email = dto.email.toLowerCase().trim();
    const existing = await this.usersRepo.findOne({ where: { email } });
    if (existing) {
      throw new BadRequestException('Email already registered');
    }

    if (dto.phone) {
      const phoneTaken = await this.usersRepo.findOne({
        where: { phone: dto.phone },
      });
      if (phoneTaken) {
        throw new BadRequestException('Phone already registered');
      }
    }

    const rounds = this.config.get<number>('bcryptRounds') ?? 12;
    const passwordHash = await bcrypt.hash(dto.password, rounds);
    const user = await this.usersRepo.save(
      this.usersRepo.create({
        fullName: dto.fullName.trim(),
        email,
        phone: dto.phone?.trim() ?? null,
        passwordHash,
      }),
    );

    if (user.phone) {
      await this.createAndStoreOtp(user.phone);
    }

    const tokens = await this.issueTokens(user);
    return { user: this.toPublicUser(user), tokens };
  }

  async login(dto: LoginDto) {
    const email = dto.email.toLowerCase().trim();
    const user = await this.usersRepo.findOne({ where: { email } });
    if (!user) {
      throw new UnauthorizedException('Invalid email or password');
    }

    const ok = await bcrypt.compare(dto.password, user.passwordHash);
    if (!ok) {
      throw new UnauthorizedException('Invalid email or password');
    }

    if (user.phone && !user.phoneVerified) {
      await this.createAndStoreOtp(user.phone);
    }

    const tokens = await this.issueTokens(user);
    return { user: this.toPublicUser(user), tokens };
  }

  async verifyOtp(dto: VerifyOtpDto) {
    const phone = dto.phone.trim();
    const code = dto.code.trim();
    if (code.length !== 6) {
      throw new BadRequestException('OTP verification failed');
    }

    const latest = await this.otpRepo
      .createQueryBuilder('o')
      .where('o.phone = :phone', { phone })
      .andWhere('o.consumed_at IS NULL')
      .andWhere('o.expires_at > NOW()')
      .orderBy('o.created_at', 'DESC')
      .getOne();

    if (!latest) {
      throw new BadRequestException('OTP expired or not found');
    }

    if (latest.codeHash !== this.hashOtp(phone, code)) {
      throw new BadRequestException('OTP verification failed');
    }

    latest.consumedAt = new Date();
    await this.otpRepo.save(latest);

    const user = await this.usersRepo.findOne({ where: { phone } });
    if (!user) {
      throw new BadRequestException('User not found for phone');
    }

    user.phoneVerified = true;
    await this.usersRepo.save(user);

    return this.issueTokens(user);
  }

  async resendOtp(dto: ResendOtpDto) {
    const phone = dto.phone.trim();
    const user = await this.usersRepo.findOne({ where: { phone } });
    if (!user) {
      throw new BadRequestException('User not found for phone');
    }
    await this.createAndStoreOtp(phone);
    return { ok: true };
  }

  async refresh(dto: RefreshTokenDto) {
    let payload: { sub: string; email: string };
    try {
      payload = await this.jwt.verifyAsync(dto.refreshToken, {
        secret: this.config.getOrThrow<string>('jwt.refreshSecret'),
      });
    } catch {
      throw new UnauthorizedException('Invalid refresh token');
    }

    const hash = this.hashToken(dto.refreshToken);
    const stored = await this.refreshRepo.findOne({
      where: { tokenHash: hash, userId: payload.sub },
    });

    if (!stored || stored.revokedAt || stored.expiresAt < new Date()) {
      throw new UnauthorizedException('Refresh token revoked or expired');
    }

    stored.revokedAt = new Date();
    await this.refreshRepo.save(stored);

    const user = await this.usersRepo.findOne({ where: { id: payload.sub } });
    if (!user) {
      throw new UnauthorizedException('User not found');
    }

    return this.issueTokens(user);
  }
}
