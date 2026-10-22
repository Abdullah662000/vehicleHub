import { Controller, Get, Param, Query, UseGuards } from '@nestjs/common';
import { Type } from 'class-transformer';
import { IsBoolean, IsNumber, IsOptional, IsString } from 'class-validator';
import { JwtAuthGuard } from '../../common/guards/jwt-auth.guard';
import { MechanicsService } from './mechanics.service';

class MechanicsQueryDto {
  @IsOptional()
  @Type(() => Number)
  @IsNumber()
  maxDistance?: number;

  @IsOptional()
  @Type(() => Boolean)
  @IsBoolean()
  verifiedOnly?: boolean;

  @IsOptional()
  @IsString()
  q?: string;

  @IsOptional()
  @Type(() => Number)
  @IsNumber()
  limit?: number;

  @IsOptional()
  @Type(() => Number)
  @IsNumber()
  offset?: number;
}

@Controller('mechanics')
@UseGuards(JwtAuthGuard)
export class MechanicsController {
  constructor(private readonly mechanicsService: MechanicsService) {}

  @Get()
  list(@Query() query: MechanicsQueryDto) {
    return this.mechanicsService.list(query);
  }

  @Get(':id')
  getOne(@Param('id') id: string) {
    return this.mechanicsService.getOne(id);
  }
}
