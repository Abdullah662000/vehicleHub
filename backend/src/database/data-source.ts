import 'reflect-metadata';
import { config as loadEnv } from 'dotenv';
import { DataSource } from 'typeorm';
import { OtpCode } from '../modules/auth/entities/otp-code.entity';
import { RefreshToken } from '../modules/auth/entities/refresh-token.entity';
import { Booking } from '../modules/bookings/entities/booking.entity';
import { Document } from '../modules/documents/entities/document.entity';
import { Expense } from '../modules/expenses/entities/expense.entity';
import { FuelEntry } from '../modules/fuel/entities/fuel-entry.entity';
import { Mechanic } from '../modules/mechanics/entities/mechanic.entity';
import { Notification } from '../modules/notifications/entities/notification.entity';
import { User } from '../modules/users/entities/user.entity';
import { ServiceRecord } from '../modules/vehicles/entities/service-record.entity';
import { Vehicle } from '../modules/vehicles/entities/vehicle.entity';
import { InitSchema1730000000000 } from './migrations/1730000000000-InitSchema';

loadEnv();

export default new DataSource({
  type: 'postgres',
  host: process.env.DATABASE_HOST,
  port: parseInt(process.env.DATABASE_PORT ?? '5432', 10),
  username: process.env.DATABASE_USER,
  password: process.env.DATABASE_PASSWORD,
  database: process.env.DATABASE_NAME,
  ssl: process.env.DATABASE_SSL === 'true' ? { rejectUnauthorized: false } : false,
  entities: [
    User,
    RefreshToken,
    OtpCode,
    Vehicle,
    ServiceRecord,
    Mechanic,
    Expense,
    Booking,
    Document,
    Notification,
    FuelEntry,
  ],
  migrations: [InitSchema1730000000000],
});
