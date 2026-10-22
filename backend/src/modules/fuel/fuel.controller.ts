import { Body, Controller, Get, Post, UseGuards } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Type } from 'class-transformer';
import {
  IsInt,
  IsNumber,
  IsOptional,
  IsString,
  Min,
  MinLength,
} from 'class-validator';
import { Repository } from 'typeorm';
import { CurrentUser } from '../../common/decorators/current-user.decorator';
import type { AuthUser } from '../../common/decorators/current-user.decorator';
import { JwtAuthGuard } from '../../common/guards/jwt-auth.guard';
import { FuelEntry } from './entities/fuel-entry.entity';

class CreateFuelDto {
  @Type(() => Number)
  @IsNumber()
  @Min(0.1)
  liters!: number;

  @Type(() => Number)
  @IsInt()
  @Min(1)
  costPkr!: number;

  @IsString()
  @MinLength(1)
  station!: string;

  @IsOptional()
  @Type(() => Number)
  @IsInt()
  odometerKm?: number;
}

@Controller('fuel')
@UseGuards(JwtAuthGuard)
export class FuelController {
  constructor(
    @InjectRepository(FuelEntry)
    private readonly repo: Repository<FuelEntry>,
  ) {}

  @Get()
  async list(@CurrentUser() user: AuthUser) {
    const rows = await this.repo.find({
      where: { userId: user.id },
      order: { filledAt: 'DESC' },
      take: 100,
    });
    return rows.map((f) => ({
      id: f.id,
      liters: Number(f.liters),
      costPkr: f.costPkr,
      station: f.station,
      odometerKm: f.odometerKm,
      filledAt: f.filledAt.toISOString(),
    }));
  }

  @Post()
  async create(@CurrentUser() user: AuthUser, @Body() dto: CreateFuelDto) {
    const row = await this.repo.save(
      this.repo.create({
        userId: user.id,
        liters: dto.liters,
        costPkr: dto.costPkr,
        station: dto.station,
        odometerKm: dto.odometerKm ?? null,
        filledAt: new Date(),
      }),
    );
    return {
      id: row.id,
      liters: Number(row.liters),
      costPkr: row.costPkr,
      station: row.station,
      odometerKm: row.odometerKm,
      filledAt: row.filledAt.toISOString(),
    };
  }
}
