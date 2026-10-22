import { IsEmail, IsOptional, IsString, MinLength } from 'class-validator';

export class LoginDto {
  @IsEmail()
  email!: string;

  @IsString()
  @MinLength(6)
  password!: string;
}

export class SignupDto {
  @IsString()
  @MinLength(2)
  fullName!: string;

  @IsEmail()
  email!: string;

  @IsString()
  @MinLength(6)
  password!: string;

  @IsOptional()
  @IsString()
  phone?: string;
}

export class VerifyOtpDto {
  @IsString()
  phone!: string;

  @IsString()
  @MinLength(6)
  code!: string;
}

export class ResendOtpDto {
  @IsString()
  phone!: string;
}

export class RefreshTokenDto {
  @IsString()
  refreshToken!: string;
}
