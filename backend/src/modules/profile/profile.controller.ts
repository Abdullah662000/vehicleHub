import { Controller, Get, UseGuards } from '@nestjs/common';
import { CurrentUser } from '../../common/decorators/current-user.decorator';
import type { AuthUser } from '../../common/decorators/current-user.decorator';
import { JwtAuthGuard } from '../../common/guards/jwt-auth.guard';
import { UsersService } from '../users/users.service';

@Controller('profile')
@UseGuards(JwtAuthGuard)
export class ProfileController {
  constructor(private readonly usersService: UsersService) {}

  @Get()
  async get(@CurrentUser() user: AuthUser) {
    const u = await this.usersService.findById(user.id);
    return {
      id: u.id,
      fullName: u.fullName,
      email: u.email,
      phone: u.phone,
      avatarUrl: u.avatarUrl,
    };
  }
}
