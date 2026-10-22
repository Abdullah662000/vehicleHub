import {
  Column,
  CreateDateColumn,
  Entity,
  Index,
  OneToMany,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';
import { RefreshToken } from '../../auth/entities/refresh-token.entity';
import { Booking } from '../../bookings/entities/booking.entity';
import { Expense } from '../../expenses/entities/expense.entity';
import { Vehicle } from '../../vehicles/entities/vehicle.entity';

@Entity('users')
export class User {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @Column({ name: 'full_name', type: 'varchar', length: 120 })
  fullName!: string;

  @Index({ unique: true })
  @Column({ type: 'varchar', length: 180 })
  email!: string;

  @Index({ unique: true })
  @Column({ type: 'varchar', length: 32, nullable: true })
  phone!: string | null;

  @Column({ name: 'password_hash', type: 'varchar', length: 255 })
  passwordHash!: string;

  @Column({ name: 'avatar_url', type: 'varchar', length: 512, nullable: true })
  avatarUrl!: string | null;

  @Column({ name: 'phone_verified', type: 'boolean', default: false })
  phoneVerified!: boolean;

  @CreateDateColumn({ name: 'created_at', type: 'timestamptz' })
  createdAt!: Date;

  @UpdateDateColumn({ name: 'updated_at', type: 'timestamptz' })
  updatedAt!: Date;

  @OneToMany(() => Vehicle, (v: Vehicle) => v.user)
  vehicles!: Vehicle[];

  @OneToMany(() => Expense, (e: Expense) => e.user)
  expenses!: Expense[];

  @OneToMany(() => Booking, (b: Booking) => b.user)
  bookings!: Booking[];

  @OneToMany(() => RefreshToken, (t: RefreshToken) => t.user)
  refreshTokens!: RefreshToken[];
}
