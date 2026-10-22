import { IsString, MinLength } from 'class-validator';

export class CreateBookingDto {
  @IsString()
  mechanicId!: string;

  @IsString()
  date!: string;

  @IsString()
  time!: string;

  @IsString()
  @MinLength(3)
  problem!: string;
}
