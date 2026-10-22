import { MigrationInterface, QueryRunner } from 'typeorm';

export class InitSchema1730000000000 implements MigrationInterface {
  name = 'InitSchema1730000000000';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`CREATE EXTENSION IF NOT EXISTS "pgcrypto"`);

    await queryRunner.query(`
      CREATE TABLE IF NOT EXISTS users (
        id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
        full_name varchar(120) NOT NULL,
        email varchar(180) NOT NULL UNIQUE,
        phone varchar(32) UNIQUE,
        password_hash varchar(255) NOT NULL,
        avatar_url varchar(512),
        phone_verified boolean NOT NULL DEFAULT false,
        created_at timestamptz NOT NULL DEFAULT now(),
        updated_at timestamptz NOT NULL DEFAULT now()
      )
    `);

    await queryRunner.query(`
      CREATE TABLE IF NOT EXISTS refresh_tokens (
        id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
        user_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
        token_hash varchar(255) NOT NULL,
        expires_at timestamptz NOT NULL,
        revoked_at timestamptz,
        created_at timestamptz NOT NULL DEFAULT now()
      )
    `);
    await queryRunner.query(
      `CREATE INDEX IF NOT EXISTS idx_refresh_user_expires ON refresh_tokens (user_id, expires_at)`,
    );

    await queryRunner.query(`
      CREATE TABLE IF NOT EXISTS otp_codes (
        id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
        phone varchar(32) NOT NULL,
        code_hash varchar(255) NOT NULL,
        expires_at timestamptz NOT NULL,
        consumed_at timestamptz,
        created_at timestamptz NOT NULL DEFAULT now()
      )
    `);
    await queryRunner.query(
      `CREATE INDEX IF NOT EXISTS idx_otp_phone_expires ON otp_codes (phone, expires_at)`,
    );

    await queryRunner.query(`
      CREATE TABLE IF NOT EXISTS vehicles (
        id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
        user_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
        photo varchar(40) NOT NULL DEFAULT 'corolla',
        make varchar(60) NOT NULL,
        model varchar(80) NOT NULL,
        year int NOT NULL,
        reg varchar(32) NOT NULL,
        mileage int NOT NULL DEFAULT 0,
        fuel_type varchar(40) NOT NULL,
        transmission varchar(40) NOT NULL,
        insurance varchar(16) NOT NULL DEFAULT 'active',
        health int NOT NULL DEFAULT 100,
        color varchar(16) NOT NULL DEFAULT '#1B4DFF',
        created_at timestamptz NOT NULL DEFAULT now(),
        updated_at timestamptz NOT NULL DEFAULT now(),
        UNIQUE (user_id, reg)
      )
    `);
    await queryRunner.query(
      `CREATE INDEX IF NOT EXISTS idx_vehicles_user ON vehicles (user_id)`,
    );

    await queryRunner.query(`
      CREATE TABLE IF NOT EXISTS service_records (
        id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
        vehicle_id uuid NOT NULL REFERENCES vehicles(id) ON DELETE CASCADE,
        title varchar(120) NOT NULL,
        workshop varchar(120) NOT NULL,
        mechanic varchar(120) NOT NULL,
        date date NOT NULL,
        cost int NOT NULL,
        parts text[] NOT NULL DEFAULT '{}',
        warranty varchar(60) NOT NULL,
        rating int NOT NULL DEFAULT 5,
        created_at timestamptz NOT NULL DEFAULT now()
      )
    `);
    await queryRunner.query(
      `CREATE INDEX IF NOT EXISTS idx_service_vehicle ON service_records (vehicle_id)`,
    );

    await queryRunner.query(`
      CREATE TABLE IF NOT EXISTS mechanics (
        id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
        name varchar(120) NOT NULL,
        workshop varchar(160) NOT NULL,
        photo varchar(40) NOT NULL DEFAULT 'm1',
        verified boolean NOT NULL DEFAULT true,
        rating numeric(3,2) NOT NULL DEFAULT 0,
        reviews int NOT NULL DEFAULT 0,
        experience int NOT NULL DEFAULT 0,
        distance numeric(6,2) NOT NULL DEFAULT 0,
        brands text[] NOT NULL DEFAULT '{}',
        services text[] NOT NULL DEFAULT '{}',
        open boolean NOT NULL DEFAULT true,
        hours varchar(80) NOT NULL,
        location varchar(180) NOT NULL,
        specialty varchar(120) NOT NULL,
        estimate varchar(80) NOT NULL,
        created_at timestamptz NOT NULL DEFAULT now(),
        updated_at timestamptz NOT NULL DEFAULT now()
      )
    `);
    await queryRunner.query(
      `CREATE INDEX IF NOT EXISTS idx_mechanics_verified ON mechanics (verified)`,
    );
    await queryRunner.query(
      `CREATE INDEX IF NOT EXISTS idx_mechanics_open ON mechanics (open)`,
    );
    await queryRunner.query(
      `CREATE INDEX IF NOT EXISTS idx_mechanics_distance ON mechanics (distance)`,
    );

    await queryRunner.query(`
      CREATE TABLE IF NOT EXISTS expenses (
        id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
        user_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
        category varchar(60) NOT NULL,
        title varchar(160) NOT NULL,
        amount int NOT NULL,
        spent_at timestamptz NOT NULL,
        icon varchar(40) NOT NULL DEFAULT 'receipt',
        created_at timestamptz NOT NULL DEFAULT now()
      )
    `);
    await queryRunner.query(
      `CREATE INDEX IF NOT EXISTS idx_expenses_user_spent ON expenses (user_id, spent_at)`,
    );
    await queryRunner.query(
      `CREATE INDEX IF NOT EXISTS idx_expenses_user_category ON expenses (user_id, category)`,
    );

    await queryRunner.query(`
      CREATE TABLE IF NOT EXISTS bookings (
        id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
        user_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
        mechanic_id uuid NOT NULL REFERENCES mechanics(id) ON DELETE RESTRICT,
        date date NOT NULL,
        time varchar(16) NOT NULL,
        problem text NOT NULL,
        status varchar(32) NOT NULL DEFAULT 'confirmed',
        created_at timestamptz NOT NULL DEFAULT now(),
        updated_at timestamptz NOT NULL DEFAULT now()
      )
    `);
    await queryRunner.query(
      `CREATE INDEX IF NOT EXISTS idx_bookings_user ON bookings (user_id)`,
    );
    await queryRunner.query(
      `CREATE INDEX IF NOT EXISTS idx_bookings_mechanic ON bookings (mechanic_id)`,
    );

    await queryRunner.query(`
      CREATE TABLE IF NOT EXISTS documents (
        id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
        user_id uuid NOT NULL,
        title varchar(120) NOT NULL,
        type varchar(40) NOT NULL,
        file_url varchar(512),
        created_at timestamptz NOT NULL DEFAULT now()
      )
    `);
    await queryRunner.query(
      `CREATE INDEX IF NOT EXISTS idx_documents_user ON documents (user_id)`,
    );

    await queryRunner.query(`
      CREATE TABLE IF NOT EXISTS notifications (
        id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
        user_id uuid NOT NULL,
        title varchar(160) NOT NULL,
        body text NOT NULL,
        read boolean NOT NULL DEFAULT false,
        created_at timestamptz NOT NULL DEFAULT now()
      )
    `);
    await queryRunner.query(
      `CREATE INDEX IF NOT EXISTS idx_notifications_user_created ON notifications (user_id, created_at)`,
    );

    await queryRunner.query(`
      CREATE TABLE IF NOT EXISTS fuel_entries (
        id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
        user_id uuid NOT NULL,
        liters numeric(8,2) NOT NULL,
        cost_pkr int NOT NULL,
        station varchar(80) NOT NULL,
        odometer_km int,
        filled_at timestamptz NOT NULL,
        created_at timestamptz NOT NULL DEFAULT now()
      )
    `);
    await queryRunner.query(
      `CREATE INDEX IF NOT EXISTS idx_fuel_user_filled ON fuel_entries (user_id, filled_at)`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`DROP TABLE IF EXISTS fuel_entries`);
    await queryRunner.query(`DROP TABLE IF EXISTS notifications`);
    await queryRunner.query(`DROP TABLE IF EXISTS documents`);
    await queryRunner.query(`DROP TABLE IF EXISTS bookings`);
    await queryRunner.query(`DROP TABLE IF EXISTS expenses`);
    await queryRunner.query(`DROP TABLE IF EXISTS mechanics`);
    await queryRunner.query(`DROP TABLE IF EXISTS service_records`);
    await queryRunner.query(`DROP TABLE IF EXISTS vehicles`);
    await queryRunner.query(`DROP TABLE IF EXISTS otp_codes`);
    await queryRunner.query(`DROP TABLE IF EXISTS refresh_tokens`);
    await queryRunner.query(`DROP TABLE IF EXISTS users`);
  }
}
