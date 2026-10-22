class AppConfig {
  AppConfig._();

  static const String appName = 'VehicleHub';

  /// Override at build/run time:
  /// `--dart-define=API_BASE_URL=http://10.0.2.2:3000/v1`
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:3000/v1',
  );

  /// Override: `--dart-define=USE_MOCK_API=true|false`
  static const bool useMockApi = bool.fromEnvironment(
    'USE_MOCK_API',
    defaultValue: false,
  );

  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 20);
}
