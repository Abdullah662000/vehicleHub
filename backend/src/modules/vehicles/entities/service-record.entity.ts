import {
  Column,
  CreateDateColumn,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { Vehicle } from './vehicle.entity';

@Entity('service_records')
@Index(['vehicleId'])
export class ServiceRecord {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @Column({ name: 'vehicle_id', type: 'uuid' })
  vehicleId!: string;

  @ManyToOne(() => Vehicle, (v) => v.serviceRecords, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'vehicle_id' })
  vehicle!: Vehicle;

  @Column({ type: 'varchar', length: 120 })
  title!: string;

  @Column({ type: 'varchar', length: 120 })
  workshop!: string;

  @Column({ type: 'varchar', length: 120 })
  mechanic!: string;

  @Column({ type: 'date' })
  date!: string;

  @Column({ type: 'int' })
  cost!: number;

  @Column({ type: 'text', array: true, default: '{}' })
  parts!: string[];

  @Column({ type: 'varchar', length: 60 })
  warranty!: string;

  @Column({ type: 'int', default: 5 })
  rating!: number;

  @CreateDateColumn({ name: 'created_at', type: 'timestamptz' })
  createdAt!: Date;
}
