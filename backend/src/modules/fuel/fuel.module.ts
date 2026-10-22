import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { FuelEntry } from './entities/fuel-entry.entity';
import { FuelController } from './fuel.controller';

@Module({
  imports: [TypeOrmModule.forFeature([FuelEntry])],
  controllers: [FuelController],
})
export class FuelModule {}
