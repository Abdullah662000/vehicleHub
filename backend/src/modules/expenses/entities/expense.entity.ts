import {
  Column,
  CreateDateColumn,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { User } from '../../users/entities/user.entity';

@Entity('expenses')
@Index(['userId', 'spentAt'])
@Index(['userId', 'category'])
export class Expense {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @Column({ name: 'user_id', type: 'uuid' })
  userId!: string;

  @ManyToOne(() => User, (u) => u.expenses, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'user_id' })
  user!: User;

  @Column({ type: 'varchar', length: 60 })
  category!: string;

  @Column({ type: 'varchar', length: 160 })
  title!: string;

  @Column({ type: 'int' })
  amount!: number;

  @Column({ name: 'spent_at', type: 'timestamptz' })
  spentAt!: Date;

  @Column({ type: 'varchar', length: 40, default: 'receipt' })
  icon!: string;

  @CreateDateColumn({ name: 'created_at', type: 'timestamptz' })
  createdAt!: Date;
}
