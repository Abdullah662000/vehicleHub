# VehicleHub API — expected contract (v1)

Base URL: configured via `--dart-define=API_BASE_URL=...`  
Default: `http://10.0.2.2:3000/v1` (Android emulator → host machine)

Auth header: `Authorization: Bearer <accessToken>`

Set `USE_MOCK_API=false` (default) to hit the NestJS backend.

## Auth

### POST /auth/login
```json
{ "email": "string", "password": "string" }
```
Response:
```json
{
  "user": { "id": "string", "fullName": "string", "email": "string", "phone": "string" },
  "tokens": { "accessToken": "string", "refreshToken": "string" }
}
```

### POST /auth/signup
```json
{ "fullName": "string", "email": "string", "phone": "string", "password": "string" }
```

### POST /auth/otp/verify
```json
{ "phone": "string", "code": "string" }
```
Response: `{ "accessToken": "string", "refreshToken": "string" }`

### POST /auth/otp/resend
```json
{ "phone": "string" }
```

### POST /auth/refresh
```json
{ "refreshToken": "string" }
```

## Resources

- `GET /vehicles` → `Vehicle[]`
- `GET /vehicles/:id` → `Vehicle`
- `POST /vehicles` → create
- `GET /vehicles/:id/service-history` → `ServiceRecord[]`
- `GET /mechanics?verifiedOnly=&maxDistance=&q=` → `Mechanic[]`
- `GET /mechanics/:id` → `Mechanic`
- `GET /expenses` → `Expense[]`
- `POST /expenses` → create
- `GET /expenses/monthly` → `{ label, value }[]`
- `GET /expenses/categories` → `{ label, value, color }[]`
- `POST /bookings` → `{ data: { id, mechanicId, date, time, problem, status } }`
- `GET /documents` · `GET /notifications` · `GET /profile` · `GET|POST /fuel`
- `GET /health` → `{ status, database }`

Demo user (after `npm run seed`): `ahmed@example.com` / `Password123!`
