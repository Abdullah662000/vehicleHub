# VehicleHub Pakistan — Flutter App

Native Flutter conversion of the VehicleHub Pakistan design prototype.

**Tagline:** Your Vehicle's Digital Companion · آپ کی گاڑی کا ڈیجیٹل ساتھی

## Requirements

- Flutter 3.44+ / Dart 3.12+ (`C:\Doculex\flutter` if installed via this project)
- Android Studio / Xcode for device builds
- Chrome optional for `flutter run -d chrome`

## Run

```powershell
cd C:\Doculex\FE\VehicleHub-Pakistan\mobile
$env:Path = "C:\Doculex\flutter\bin;" + $env:Path
flutter pub get
flutter run
```

## What's included

### User journey
Splash → Onboarding (4) → Language (EN/اردو) → Login / Signup → OTP → Vehicle registration → Main app

### Main tabs
Home · Garage · Mechanics · Expenses · Profile

### Secondary flows
Vehicle details, service history, mechanic profile, booking, fuel tracker, roadside SOS, documents, notifications, search, settings, empty/error states, design system

### Design system
- Royal Blue `#1B4DFF`, Emerald `#10B981`, Orange `#FF7A1A`
- Light / Dark themes (Material 3 + Poppins)
- Bilingual EN + Urdu with RTL
- Shared widgets: buttons, inputs, cards, badges, chips, empty states, vehicle art

### Performance
- Riverpod selective rebuilds
- `ListView.builder` / `IndexedStack` shell
- Mock API path avoids network latency in UI development
- Const widgets where practical
- Dio timeouts + secure token storage ready for production

## API integration (basic setup)

Config: `lib/core/config/app_config.dart`

| Setting | Default |
| --- | --- |
| `API_BASE_URL` | `http://10.0.2.2:3000/v1` (Android emulator) |
| `USE_MOCK_API` | `false` |
| Timeouts | connect 15s · receive 20s |

Point at NestJS backend:

```powershell
cd mobile
# Android emulator
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:3000/v1 --dart-define=USE_MOCK_API=false

# Chrome / Windows
flutter run -d chrome --dart-define=API_BASE_URL=http://localhost:3000/v1 --dart-define=USE_MOCK_API=false
```

Backend lives in [`../backend`](../backend). Start Postgres + API first:

```powershell
cd ../backend
copy .env.example .env
npm install
npm run docker:up
npm run start:dev
npm run seed
```

## Project structure

```
lib/
  main.dart / app.dart
  core/          config, theme, network, storage
  data/          models, mock, datasources, repositories
  features/      splash, auth, home, garage, mechanics, expenses, …
  l10n/          bilingual strings
  providers/     Riverpod
  router/        go_router
  shared/        design-system widgets
```

## Design prototype

The web design studio lives one level up:

```powershell
cd C:\Doculex\FE\VehicleHub-Pakistan
npm run dev
```
