import {
  ConflictException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { photoKeyForModel } from '../../common/utils/helpers';
import { CreateVehicleDto } from './dto/create-vehicle.dto';
import { ServiceRecord } from './entities/service-record.entity';
import { Vehicle } from './entities/vehicle.entity';

@Injectable()
export class VehiclesService {
  constructor(
    @InjectRepository(Vehicle)
    private readonly vehiclesRepo: Repository<Vehicle>,
    @InjectRepository(ServiceRecord)
    private readonly serviceRepo: Repository<ServiceRecord>,
  ) {}

  private toClient(v: Vehicle) {
    return {
      id: v.id,
      photo: v.photo,
      make: v.make,
      model: v.model,
      year: v.year,
      reg: v.reg,
      mileage: v.mileage,
      fuelType: v.fuelType,
      transmission: v.transmission,
      insurance: v.insurance,
      health: v.health,
      color: v.color,
    };
  }

  async list(userId: string) {
    const rows = await this.vehiclesRepo.find({
      where: { userId },
      order: { createdAt: 'DESC' },
      select: {
        id: true,
        photo: true,
        make: true,
        model: true,
        year: true,
        reg: true,
        mileage: true,
        fuelType: true,
        transmission: true,
        insurance: true,
        health: true,
        color: true,
      },
    });
    return rows.map((v) => this.toClient(v));
  }

  async getOne(userId: string, id: string) {
    const v = await this.vehiclesRepo.findOne({ where: { id, userId } });
    if (!v) throw new NotFoundException('Vehicle not found');
    return this.toClient(v);
  }

  async create(userId: string, dto: CreateVehicleDto) {
    const exists = await this.vehiclesRepo.findOne({
      where: { userId, reg: dto.reg.trim().toUpperCase() },
    });
    if (exists) {
      throw new ConflictException('Vehicle with this registration exists');
    }

    const vehicle = await this.vehiclesRepo.save(
      this.vehiclesRepo.create({
        userId,
        make: dto.make.trim(),
        model: dto.model.trim(),
        year: dto.year,
        reg: dto.reg.trim().toUpperCase(),
        fuelType: dto.fuelType,
        transmission: dto.transmission,
        mileage: dto.mileage ?? 0,
        photo: dto.photo ?? photoKeyForModel(dto.model),
        color: dto.color ?? '#1B4DFF',
        health: 100,
        insurance: 'active',
      }),
    );
    return this.toClient(vehicle);
  }

  async serviceHistory(userId: string, vehicleId: string) {
    const owned = await this.vehiclesRepo.exists({
      where: { id: vehicleId, userId },
    });
    if (!owned) throw new NotFoundException('Vehicle not found');

    const rows = await this.serviceRepo.find({
      where: { vehicleId },
      order: { date: 'DESC' },
    });

    return rows.map((s) => ({
      id: s.id,
      title: s.title,
      workshop: s.workshop,
      mechanic: s.mechanic,
      date: s.date,
      cost: s.cost,
      parts: s.parts,
      warranty: s.warranty,
      rating: s.rating,
    }));
  }
}
