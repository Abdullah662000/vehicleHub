import {
  Column,
  CreateDateColumn,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
  Unique,
  UpdateDateColumn,
} from 'typeorm';
import { User } from '../../users/entities/user.entity';
import { ServiceRecord } from './service-record.entity';

export type InsuranceStatus = 'active' | 'expiring' | 'expired';

@Entity('vehicles')
@Unique(['userId', 'reg'])
@Index(['userId'])
export class Vehicle {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @Column({ name: 'user_id', type: 'uuid' })
  userId!: string;

  @ManyToOne(() => User, (u) => u.vehicles, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'user_id' })
  user!: User;

  @Column({ type: 'varchar', length: 40, default: 'corolla' })
  photo!: string;

  @Column({ type: 'varchar', length: 60 })
  make!: string;

  @Column({ type: 'varchar', length: 80 })
  model!: string;

  @Column({ type: 'int' })
  year!: number;

  @Column({ type: 'varchar', length: 32 })
  reg!: string;

  @Column({ type: 'int', default: 0 })
  mileage!: number;

  @Column({ name: 'fuel_type', type: 'varchar', length: 40 })
  fuelType!: string;

  @Column({ type: 'varchar', length: 40 })
  transmission!: string;

  @Column({ type: 'varchar', length: 16, default: 'active' })
  insurance!: InsuranceStatus;

  @Column({ type: 'int', default: 100 })
  health!: number;

  @Column({ type: 'varchar', length: 16, default: '#1B4DFF' })
  color!: string;

  @OneToMany(() => ServiceRecord, (s) => s.vehicle)
  serviceRecords!: ServiceRecord[];

  @CreateDateColumn({ name: 'created_at', type: 'timestamptz' })
  createdAt!: Date;

  @UpdateDateColumn({ name: 'updated_at', type: 'timestamptz' })
  updatedAt!: Date;
}
