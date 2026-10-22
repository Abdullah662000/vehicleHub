import {
  Column,
  CreateDateColumn,
  Entity,
  Index,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';

@Entity('mechanics')
@Index(['verified'])
@Index(['open'])
@Index(['distance'])
export class Mechanic {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @Column({ type: 'varchar', length: 120 })
  name!: string;

  @Column({ type: 'varchar', length: 160 })
  workshop!: string;

  @Column({ type: 'varchar', length: 40, default: 'm1' })
  photo!: string;

  @Column({ type: 'boolean', default: true })
  verified!: boolean;

  @Column({ type: 'numeric', precision: 3, scale: 2, default: 0 })
  rating!: number;

  @Column({ type: 'int', default: 0 })
  reviews!: number;

  @Column({ type: 'int', default: 0 })
  experience!: number;

  @Column({ type: 'numeric', precision: 6, scale: 2, default: 0 })
  distance!: number;

  @Column({ type: 'text', array: true, default: '{}' })
  brands!: string[];

  @Column({ type: 'text', array: true, default: '{}' })
  services!: string[];

  @Column({ type: 'boolean', default: true })
  open!: boolean;

  @Column({ type: 'varchar', length: 80 })
  hours!: string;

  @Column({ type: 'varchar', length: 180 })
  location!: string;

  @Column({ type: 'varchar', length: 120 })
  specialty!: string;

  @Column({ type: 'varchar', length: 80 })
  estimate!: string;

  @CreateDateColumn({ name: 'created_at', type: 'timestamptz' })
  createdAt!: Date;

  @UpdateDateColumn({ name: 'updated_at', type: 'timestamptz' })
  updatedAt!: Date;
}
