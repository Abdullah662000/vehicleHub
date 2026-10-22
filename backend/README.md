# VehicleHub Pakistan — NestJS API

Production-oriented NestJS + PostgreSQL backend for the Flutter app.

## Quick start

```powershell
cd backend
copy .env.example .env   # then set real secrets + DATABASE_PASSWORD
npm install
npm run docker:up        # preferred: Postgres 16 via Docker
# OR use local Postgres: create role/db with scripts/setup-db.sql
npm run start:dev        # syncs schema in development
npm run seed
```

If Docker Desktop is unavailable, install PostgreSQL 16 locally, run `scripts/setup-db.sql` as the `postgres` superuser, and put that role password in `.env` as `DATABASE_PASSWORD`.

API base: `http://localhost:3000/v1`  
Health: `GET http://localhost:3000/v1/health`

Demo user (after seed): `ahmed@example.com` / `Password123!`

## Scripts

| Script | Purpose |
| --- | --- |
| `npm run start:dev` | Watch mode |
| `npm run docker:up` | Start Postgres 16 |
| `npm run migration:run` | Apply SQL migrations (production) |
| `npm run seed` | Seed mechanics + demo user data |

## Env

All secrets come from `.env` (see `.env.example`). The app refuses to boot if JWT/DB/OTP secrets are missing.

## Auth

- `POST /v1/auth/signup|login` → `{ user, tokens }`
- `POST /v1/auth/otp/verify|resend`
- `POST /v1/auth/refresh`
- Bearer JWT on protected routes

OTP codes are hashed with `OTP_PEPPER` and logged to the console in non-production.
