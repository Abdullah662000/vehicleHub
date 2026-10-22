import {
  Column,
  CreateDateColumn,
  Entity,
  Index,
  PrimaryGeneratedColumn,
} from 'typeorm';

@Entity('fuel_entries')
@Index(['userId', 'filledAt'])
export class FuelEntry {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @Column({ name: 'user_id', type: 'uuid' })
  userId!: string;

  @Column({ type: 'numeric', precision: 8, scale: 2 })
  liters!: number;

  @Column({ name: 'cost_pkr', type: 'int' })
  costPkr!: number;

  @Column({ type: 'varchar', length: 80 })
  station!: string;

  @Column({ name: 'odometer_km', type: 'int', nullable: true })
  odometerKm!: number | null;

  @Column({ name: 'filled_at', type: 'timestamptz' })
  filledAt!: Date;

  @CreateDateColumn({ name: 'created_at', type: 'timestamptz' })
  createdAt!: Date;
}
