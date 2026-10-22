import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Mechanic } from './entities/mechanic.entity';

@Injectable()
export class MechanicsService {
  constructor(
    @InjectRepository(Mechanic)
    private readonly mechanicsRepo: Repository<Mechanic>,
  ) {}

  private toClient(m: Mechanic) {
    return {
      id: m.id,
      name: m.name,
      workshop: m.workshop,
      photo: m.photo,
      verified: m.verified,
      rating: Number(m.rating),
      reviews: m.reviews,
      experience: m.experience,
      distance: Number(m.distance),
      brands: m.brands,
      services: m.services,
      open: m.open,
      hours: m.hours,
      location: m.location,
      specialty: m.specialty,
      estimate: m.estimate,
    };
  }

  async list(query: {
    maxDistance?: number;
    verifiedOnly?: boolean;
    q?: string;
    limit?: number;
    offset?: number;
  }) {
    const qb = this.mechanicsRepo
      .createQueryBuilder('m')
      .orderBy('m.distance', 'ASC')
      .take(Math.min(query.limit ?? 50, 100))
      .skip(query.offset ?? 0);

    if (query.verifiedOnly) {
      qb.andWhere('m.verified = true');
    }
    if (query.maxDistance != null) {
      qb.andWhere('m.distance <= :maxDistance', {
        maxDistance: query.maxDistance,
      });
    }
    if (query.q?.trim()) {
      qb.andWhere(
        '(m.name ILIKE :q OR m.workshop ILIKE :q OR m.location ILIKE :q OR m.specialty ILIKE :q)',
        { q: `%${query.q.trim()}%` },
      );
    }

    const rows = await qb.getMany();
    return rows.map((m) => this.toClient(m));
  }

  async getOne(id: string) {
    const m = await this.mechanicsRepo.findOne({ where: { id } });
    if (!m) throw new NotFoundException('Mechanic not found');
    return this.toClient(m);
  }
}
