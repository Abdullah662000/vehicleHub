import { Module } from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { APP_GUARD } from '@nestjs/core';
import { ThrottlerGuard, ThrottlerModule } from '@nestjs/throttler';
import { TypeOrmModule } from '@nestjs/typeorm';
import configuration from './config/configuration';
import { envValidationSchema } from './config/env.validation';
import { AuthModule } from './modules/auth/auth.module';
import { OtpCode } from './modules/auth/entities/otp-code.entity';
import { RefreshToken } from './modules/auth/entities/refresh-token.entity';
import { BookingsModule } from './modules/bookings/bookings.module';
import { Booking } from './modules/bookings/entities/booking.entity';
import { DocumentsModule } from './modules/documents/documents.module';
import { Document } from './modules/documents/entities/document.entity';
import { ExpensesModule } from './modules/expenses/expenses.module';
import { Expense } from './modules/expenses/entities/expense.entity';
import { FuelModule } from './modules/fuel/fuel.module';
import { FuelEntry } from './modules/fuel/entities/fuel-entry.entity';
import { HealthModule } from './modules/health/health.module';
import { MechanicsModule } from './modules/mechanics/mechanics.module';
import { Mechanic } from './modules/mechanics/entities/mechanic.entity';
import { NotificationsModule } from './modules/notifications/notifications.module';
import { Notification } from './modules/notifications/entities/notification.entity';
import { ProfileModule } from './modules/profile/profile.module';
import { UsersModule } from './modules/users/users.module';
import { User } from './modules/users/entities/user.entity';
import { VehiclesModule } from './modules/vehicles/vehicles.module';
import { ServiceRecord } from './modules/vehicles/entities/service-record.entity';
import { Vehicle } from './modules/vehicles/entities/vehicle.entity';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      load: [configuration],
      validationSchema: envValidationSchema,
      validationOptions: { abortEarly: false },
    }),
    ThrottlerModule.forRootAsync({
      inject: [ConfigService],
      useFactory: (config: ConfigService) => [
        {
          ttl: config.get<number>('throttle.ttl') ?? 60000,
          limit: config.get<number>('throttle.limit') ?? 100,
        },
      ],
    }),
    TypeOrmModule.forRootAsync({
      inject: [ConfigService],
      useFactory: (config: ConfigService) => {
        const isProd = config.get('nodeEnv') === 'production';
        return {
          type: 'postgres' as const,
          host: config.getOrThrow<string>('database.host'),
          port: config.getOrThrow<number>('database.port'),
          username: config.getOrThrow<string>('database.username'),
          password: config.getOrThrow<string>('database.password'),
          database: config.getOrThrow<string>('database.name'),
          ssl: config.get<boolean>('database.ssl')
            ? { rejectUnauthorized: false }
            : false,
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
          synchronize: !isProd,
          logging: config.get('nodeEnv') === 'development',
          extra: {
            max: config.get<number>('database.poolMax') ?? 20,
          },
        };
      },
    }),
    AuthModule,
    UsersModule,
    VehiclesModule,
    MechanicsModule,
    ExpensesModule,
    BookingsModule,
    ProfileModule,
    NotificationsModule,
    DocumentsModule,
    FuelModule,
    HealthModule,
  ],
  providers: [
    {
      provide: APP_GUARD,
      useClass: ThrottlerGuard,
    },
  ],
})
export class AppModule {}
