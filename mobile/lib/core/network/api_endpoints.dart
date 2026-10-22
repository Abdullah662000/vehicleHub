class ApiEndpoints {
  ApiEndpoints._();

  // Auth
  static const String login = '/auth/login';
  static const String signup = '/auth/signup';
  static const String otpVerify = '/auth/otp/verify';
  static const String otpResend = '/auth/otp/resend';
  static const String refreshToken = '/auth/refresh';

  // Vehicles
  static const String vehicles = '/vehicles';
  static String vehicle(String id) => '/vehicles/$id';

  // Mechanics
  static const String mechanics = '/mechanics';
  static String mechanic(String id) => '/mechanics/$id';

  // Expenses
  static const String expenses = '/expenses';
  static String expense(String id) => '/expenses/$id';

  // Fuel
  static const String fuel = '/fuel';
  static String fuelEntry(String id) => '/fuel/$id';

  // Bookings
  static const String bookings = '/bookings';
  static String booking(String id) => '/bookings/$id';

  // Documents
  static const String documents = '/documents';
  static String document(String id) => '/documents/$id';

  // Notifications
  static const String notifications = '/notifications';

  // Profile
  static const String profile = '/profile';
}
