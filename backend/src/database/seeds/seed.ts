import 'reflect-metadata';
import * as bcrypt from 'bcrypt';
import { config as loadEnv } from 'dotenv';
import dataSource from '../data-source';
import { User } from '../../modules/users/entities/user.entity';
import { Mechanic } from '../../modules/mechanics/entities/mechanic.entity';
import { Vehicle } from '../../modules/vehicles/entities/vehicle.entity';
import { ServiceRecord } from '../../modules/vehicles/entities/service-record.entity';
import { Expense } from '../../modules/expenses/entities/expense.entity';
import { Notification } from '../../modules/notifications/entities/notification.entity';

loadEnv();

async function seed() {
  await dataSource.initialize();
  const users = dataSource.getRepository(User);
  const mechanics = dataSource.getRepository(Mechanic);
  const vehicles = dataSource.getRepository(Vehicle);
  const services = dataSource.getRepository(ServiceRecord);
  const expenses = dataSource.getRepository(Expense);
  const notifications = dataSource.getRepository(Notification);

  const rounds = parseInt(process.env.BCRYPT_ROUNDS ?? '12', 10);
  const passwordHash = await bcrypt.hash('Password123!', rounds);

  let user = await users.findOne({ where: { email: 'ahmed@example.com' } });
  if (!user) {
    user = await users.save(
      users.create({
        fullName: 'Ahmed Khan',
        email: 'ahmed@example.com',
        phone: '+923001234567',
        passwordHash,
        phoneVerified: true,
      }),
    );
    // eslint-disable-next-line no-console
    console.log('Seeded demo user ahmed@example.com / Password123!');
  }

  const mechanicCount = await mechanics.count();
  if (mechanicCount === 0) {
    await mechanics.save([
      mechanics.create({
        name: 'Usman Ali',
        workshop: 'Ali Auto Care',
        photo: 'm1',
        verified: true,
        rating: 4.9,
        reviews: 312,
        experience: 14,
        distance: 1.2,
        brands: ['Toyota', 'Honda', 'Suzuki'],
        services: ['Engine', 'AC', 'Oil Change', 'Suspension'],
        open: true,
        hours: '9:00 AM – 9:00 PM',
        location: 'Gulberg III, Lahore',
        specialty: 'Toyota Specialist',
        estimate: 'PKR 2,500 – 8,000',
      }),
      mechanics.create({
        name: 'Bilal Khan',
        workshop: 'Khan Motors',
        photo: 'm2',
        verified: true,
        rating: 4.7,
        reviews: 198,
        experience: 9,
        distance: 2.8,
        brands: ['Honda', 'MG', 'Hyundai'],
        services: ['Denting', 'Painting', 'Battery', 'Tyres'],
        open: true,
        hours: '10:00 AM – 8:00 PM',
        location: 'F-10 Markaz, Islamabad',
        specialty: 'Honda Specialist',
        estimate: 'PKR 3,000 – 12,000',
      }),
      mechanics.create({
        name: 'Asif Raza',
        workshop: 'German Car Lab',
        photo: 'm3',
        verified: true,
        rating: 4.8,
        reviews: 87,
        experience: 11,
        distance: 4.1,
        brands: ['BMW', 'Mercedes', 'Audi'],
        services: ['Diagnostics', 'Transmission', 'Engine'],
        open: false,
        hours: '11:00 AM – 7:00 PM',
        location: 'DHA Phase 5, Karachi',
        specialty: 'German Cars',
        estimate: 'PKR 8,000 – 35,000',
      }),
      mechanics.create({
        name: 'Sana Workshop',
        workshop: 'QuickFix Mobile',
        photo: 'm4',
        verified: true,
        rating: 4.6,
        reviews: 156,
        experience: 6,
        distance: 0.9,
        brands: ['Suzuki', 'Toyota', 'Kia'],
        services: ['Emergency', 'Battery', 'Flat Tyre'],
        open: true,
        hours: '24/7',
        location: 'Johar Town, Lahore',
        specialty: 'Emergency',
        estimate: 'PKR 1,500 – 5,000',
      }),
    ]);
    // eslint-disable-next-line no-console
    console.log('Seeded mechanics');
  }

  const vehicleCount = await vehicles.count({ where: { userId: user.id } });
  if (vehicleCount === 0) {
    const [v1] = await vehicles.save([
      vehicles.create({
        userId: user.id,
        photo: 'corolla',
        make: 'Toyota',
        model: 'Corolla Gli',
        year: 2021,
        reg: 'LES-2041',
        mileage: 48250,
        fuelType: 'Petrol',
        transmission: 'Automatic',
        insurance: 'expiring',
        health: 86,
        color: '#1B4DFF',
      }),
      vehicles.create({
        userId: user.id,
        photo: 'civic',
        make: 'Honda',
        model: 'Civic Oriel',
        year: 2019,
        reg: 'ICT-8892',
        mileage: 71400,
        fuelType: 'Petrol',
        transmission: 'Automatic',
        insurance: 'active',
        health: 78,
        color: '#10B981',
      }),
      vehicles.create({
        userId: user.id,
        photo: 'sportage',
        make: 'Kia',
        model: 'Sportage AWD',
        year: 2023,
        reg: 'RWP-5510',
        mileage: 12680,
        fuelType: 'Petrol',
        transmission: 'Automatic',
        insurance: 'active',
        health: 94,
        color: '#FF7A1A',
      }),
    ]);

    await services.save([
      services.create({
        vehicleId: v1.id,
        title: 'Full oil change',
        workshop: 'Ali Auto Care',
        mechanic: 'Usman Ali',
        date: '2026-06-12',
        cost: 6500,
        parts: ['Synthetic oil 4L', 'Oil filter'],
        warranty: '30 days',
        rating: 5,
      }),
      services.create({
        vehicleId: v1.id,
        title: 'AC gas refill',
        workshop: 'Khan Motors',
        mechanic: 'Bilal Khan',
        date: '2026-03-03',
        cost: 4500,
        parts: ['R134a gas'],
        warranty: '15 days',
        rating: 4,
      }),
      services.create({
        vehicleId: v1.id,
        title: 'Front brake pads',
        workshop: 'Ali Auto Care',
        mechanic: 'Usman Ali',
        date: '2025-11-18',
        cost: 12500,
        parts: ['Ceramic pads', 'Brake fluid'],
        warranty: '90 days',
        rating: 5,
      }),
    ]);

    const now = Date.now();
    await expenses.save([
      expenses.create({
        userId: user.id,
        category: 'Fuel',
        title: 'PSO Petrol — 32L',
        amount: 8960,
        spentAt: new Date(now),
        icon: 'fuel',
      }),
      expenses.create({
        userId: user.id,
        category: 'Service',
        title: 'Oil change + filter',
        amount: 6500,
        spentAt: new Date(now - 86400000),
        icon: 'wrench',
      }),
      expenses.create({
        userId: user.id,
        category: 'Toll Tax',
        title: 'M2 Motorway',
        amount: 850,
        spentAt: new Date(now - 2 * 86400000),
        icon: 'road',
      }),
      expenses.create({
        userId: user.id,
        category: 'Car Wash',
        title: 'Foam wash — Gulberg',
        amount: 1200,
        spentAt: new Date(now - 4 * 86400000),
        icon: 'droplets',
      }),
      expenses.create({
        userId: user.id,
        category: 'Parking',
        title: 'Packages Mall',
        amount: 200,
        spentAt: new Date(now - 5 * 86400000),
        icon: 'parking',
      }),
    ]);

    await notifications.save([
      notifications.create({
        userId: user.id,
        title: 'Insurance expiring',
        body: 'Toyota Corolla Gli insurance expires in 18 days.',
        read: false,
      }),
      notifications.create({
        userId: user.id,
        title: 'Service due',
        body: 'Oil change recommended at 50,000 km.',
        read: false,
      }),
    ]);

    // eslint-disable-next-line no-console
    console.log('Seeded vehicles, service history, expenses, notifications');
  }

  await dataSource.destroy();
  // eslint-disable-next-line no-console
  console.log('Seed complete');
}

seed().catch(async (err) => {
  // eslint-disable-next-line no-console
  console.error(err);
  if (dataSource.isInitialized) await dataSource.destroy();
  process.exit(1);
});
