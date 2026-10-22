import {
  Column,
  CreateDateColumn,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';
import { User } from '../../users/entities/user.entity';
import { Mechanic } from '../../mechanics/entities/mechanic.entity';

@Entity('bookings')
@Index(['userId'])
@Index(['mechanicId'])
export class Booking {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @Column({ name: 'user_id', type: 'uuid' })
  userId!: string;

  @ManyToOne(() => User, (u) => u.bookings, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'user_id' })
  user!: User;

  @Column({ name: 'mechanic_id', type: 'uuid' })
  mechanicId!: string;

  @ManyToOne(() => Mechanic, { onDelete: 'RESTRICT' })
  @JoinColumn({ name: 'mechanic_id' })
  mechanic!: Mechanic;

  @Column({ type: 'date' })
  date!: string;

  @Column({ type: 'varchar', length: 16 })
  time!: string;

  @Column({ type: 'text' })
  problem!: string;

  @Column({ type: 'varchar', length: 32, default: 'confirmed' })
  status!: string;

  @CreateDateColumn({ name: 'created_at', type: 'timestamptz' })
  createdAt!: Date;

  @UpdateDateColumn({ name: 'updated_at', type: 'timestamptz' })
  updatedAt!: Date;
}
