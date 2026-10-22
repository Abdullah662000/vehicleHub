import { Type } from 'class-transformer';
import {
  IsInt,
  IsOptional,
  IsString,
  Max,
  Min,
  MinLength,
} from 'class-validator';

export class CreateVehicleDto {
  @IsString()
  @MinLength(1)
  make!: string;

  @IsString()
  @MinLength(1)
  model!: string;

  @Type(() => Number)
  @IsInt()
  @Min(1980)
  @Max(2100)
  year!: number;

  @IsString()
  @MinLength(3)
  reg!: string;

  @IsString()
  fuelType!: string;

  @IsString()
  transmission!: string;

  @Type(() => Number)
  @IsInt()
  @Min(0)
  @IsOptional()
  mileage?: number;

  @IsOptional()
  @IsString()
  photo?: string;

  @IsOptional()
  @IsString()
  color?: string;
}
