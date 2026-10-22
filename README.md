# VehicleHub Pakistan

Premium bilingual (English + Urdu) automotive companion for Pakistani vehicle owners.

## Projects

| Path | Description |
| --- | --- |
| [`backend/`](./backend) | **NestJS + PostgreSQL API** |
| [`mobile/`](./mobile) | Flutter production app (Android + iOS) |
| `/` | Interactive web design prototype (Vite + React) |

## Backend API

```powershell
cd backend
copy .env.example .env
npm install
npm run docker:up
npm run start:dev
npm run seed
```

API: http://localhost:3000/v1 · Health: http://localhost:3000/v1/health  
Demo: `ahmed@example.com` / `Password123!`

See [`backend/README.md`](./backend/README.md).

## Flutter app

```powershell
cd mobile
flutter pub get
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:3000/v1 --dart-define=USE_MOCK_API=false
```

(Use `http://localhost:3000/v1` for Chrome / Windows desktop.)

See [`mobile/README.md`](./mobile/README.md) and [`mobile/docs/API.md`](./mobile/docs/API.md).

## Design prototype

```powershell
npm install
npm run dev
```

Open http://localhost:5173
