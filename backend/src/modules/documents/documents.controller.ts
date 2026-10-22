import { Controller, Get, UseGuards } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CurrentUser } from '../../common/decorators/current-user.decorator';
import type { AuthUser } from '../../common/decorators/current-user.decorator';
import { JwtAuthGuard } from '../../common/guards/jwt-auth.guard';
import { Document } from './entities/document.entity';

@Controller('documents')
@UseGuards(JwtAuthGuard)
export class DocumentsController {
  constructor(
    @InjectRepository(Document)
    private readonly repo: Repository<Document>,
  ) {}

  @Get()
  async list(@CurrentUser() user: AuthUser) {
    const rows = await this.repo.find({
      where: { userId: user.id },
      order: { createdAt: 'DESC' },
      take: 50,
    });
    return rows.map((d) => ({
      id: d.id,
      title: d.title,
      type: d.type,
      fileUrl: d.fileUrl,
      createdAt: d.createdAt.toISOString(),
    }));
  }
}
