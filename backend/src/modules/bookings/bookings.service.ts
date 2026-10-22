import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Mechanic } from '../mechanics/entities/mechanic.entity';
import { CreateBookingDto } from './dto/create-booking.dto';
import { Booking } from './entities/booking.entity';

@Injectable()
export class BookingsService {
  constructor(
    @InjectRepository(Booking)
    private readonly bookingsRepo: Repository<Booking>,
    @InjectRepository(Mechanic)
    private readonly mechanicsRepo: Repository<Mechanic>,
  ) {}

  async create(userId: string, dto: CreateBookingDto) {
    const mechanic = await this.mechanicsRepo.findOne({
      where: { id: dto.mechanicId },
    });
    if (!mechanic) throw new NotFoundException('Mechanic not found');

    const booking = await this.bookingsRepo.save(
      this.bookingsRepo.create({
        userId,
        mechanicId: dto.mechanicId,
        date: dto.date,
        time: dto.time,
        problem: dto.problem.trim(),
        status: 'confirmed',
      }),
    );

    return {
      data: {
        id: booking.id,
        mechanicId: booking.mechanicId,
        date: booking.date,
        time: booking.time,
        problem: booking.problem,
        status: booking.status,
      },
    };
  }
}
