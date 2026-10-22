import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import {
  CATEGORY_COLORS,
  formatRelativeDate,
} from '../../common/utils/helpers';
import { CreateExpenseDto } from './dto/create-expense.dto';
import { Expense } from './entities/expense.entity';

@Injectable()
export class ExpensesService {
  constructor(
    @InjectRepository(Expense)
    private readonly expensesRepo: Repository<Expense>,
  ) {}

  private toClient(e: Expense) {
    return {
      id: e.id,
      category: e.category,
      title: e.title,
      amount: e.amount,
      date: formatRelativeDate(e.spentAt),
      icon: e.icon,
    };
  }

  async list(userId: string, limit = 100, offset = 0) {
    const rows = await this.expensesRepo.find({
      where: { userId },
      order: { spentAt: 'DESC' },
      take: Math.min(limit, 200),
      skip: offset,
    });
    return rows.map((e) => this.toClient(e));
  }

  async create(userId: string, dto: CreateExpenseDto) {
    const spentAt = dto.date ? new Date(dto.date) : new Date();
    const row = await this.expensesRepo.save(
      this.expensesRepo.create({
        userId,
        category: dto.category.trim(),
        title: dto.title.trim(),
        amount: dto.amount,
        spentAt: Number.isNaN(spentAt.getTime()) ? new Date() : spentAt,
        icon: dto.icon ?? 'receipt',
      }),
    );
    return this.toClient(row);
  }

  async monthly(userId: string) {
    const rows = await this.expensesRepo
      .createQueryBuilder('e')
      .select(`to_char(date_trunc('month', e.spent_at), 'Mon')`, 'label')
      .addSelect('COALESCE(SUM(e.amount), 0)', 'value')
      .addSelect(`date_trunc('month', e.spent_at)`, 'month')
      .where('e.user_id = :userId', { userId })
      .andWhere(`e.spent_at >= NOW() - INTERVAL '12 months'`)
      .groupBy(`date_trunc('month', e.spent_at)`)
      .orderBy(`date_trunc('month', e.spent_at)`, 'ASC')
      .getRawMany<{ label: string; value: string }>();

    return rows.map((r) => ({
      label: r.label,
      value: Number(r.value),
    }));
  }

  async categories(userId: string) {
    const rows = await this.expensesRepo
      .createQueryBuilder('e')
      .select('e.category', 'label')
      .addSelect('COALESCE(SUM(e.amount), 0)', 'value')
      .where('e.user_id = :userId', { userId })
      .groupBy('e.category')
      .orderBy('value', 'DESC')
      .getRawMany<{ label: string; value: string }>();

    const total = rows.reduce((sum, r) => sum + Number(r.value), 0) || 1;
    return rows.map((r) => ({
      label: r.label,
      value: Math.round((Number(r.value) / total) * 100),
      color: CATEGORY_COLORS[r.label] ?? CATEGORY_COLORS.Other,
    }));
  }
}
