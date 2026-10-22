import 'package:dio/dio.dart';
import 'package:vehiclehub_pakistan/core/config/app_config.dart';
import 'package:vehiclehub_pakistan/core/network/api_client.dart';
import 'package:vehiclehub_pakistan/core/network/api_endpoints.dart';
import 'package:vehiclehub_pakistan/core/network/api_exception.dart';
import 'package:vehiclehub_pakistan/data/models/user.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<({User user, AuthTokens tokens})> login({
    required String email,
    required String password,
  }) async {
    if (AppConfig.useMockApi) {
      await Future<void>.delayed(const Duration(milliseconds: 400));
      return (
        user: const User(
          id: 'u1',
          fullName: 'Ahmed Khan',
          email: 'ahmed@example.com',
          phone: '+923001234567',
        ),
        tokens: const AuthTokens(
          accessToken: 'mock_access_token',
          refreshToken: 'mock_refresh_token',
        ),
      );
    }

    try {
      final response = await _apiClient.post<Map<String, dynamic>>(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
      );
      final data = response.data!;
      return (
        user: User.fromJson(data['user'] as Map<String, dynamic>),
        tokens: AuthTokens.fromJson(data['tokens'] as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<({User user, AuthTokens tokens})> signup({
    required String fullName,
    required String email,
    required String password,
    String? phone,
  }) async {
    if (AppConfig.useMockApi) {
      await Future<void>.delayed(const Duration(milliseconds: 400));
      return (
        user: User(
          id: 'u1',
          fullName: fullName,
          email: email,
          phone: phone,
        ),
        tokens: const AuthTokens(
          accessToken: 'mock_access_token',
          refreshToken: 'mock_refresh_token',
        ),
      );
    }

    try {
      final response = await _apiClient.post<Map<String, dynamic>>(
        ApiEndpoints.signup,
        data: {
          'fullName': fullName,
          'email': email,
          'password': password,
          if (phone != null) 'phone': phone,
        },
      );
      final data = response.data!;
      return (
        user: User.fromJson(data['user'] as Map<String, dynamic>),
        tokens: AuthTokens.fromJson(data['tokens'] as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<AuthTokens> verifyOtp({
    required String phone,
    required String code,
  }) async {
    if (AppConfig.useMockApi) {
      await Future<void>.delayed(const Duration(milliseconds: 300));
      if (code.length != 6) {
        throw const NetworkException(message: 'OTP verification failed');
      }
      return const AuthTokens(
        accessToken: 'mock_access_token',
        refreshToken: 'mock_refresh_token',
      );
    }

    try {
      final response = await _apiClient.post<Map<String, dynamic>>(
        ApiEndpoints.otpVerify,
        data: {'phone': phone, 'code': code},
      );
      return AuthTokens.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<void> resendOtp({required String phone}) async {
    if (AppConfig.useMockApi) {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      return;
    }

    try {
      await _apiClient.post<void>(
        ApiEndpoints.otpResend,
        data: {'phone': phone},
      );
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<AuthTokens> refreshToken({required String refreshToken}) async {
    if (AppConfig.useMockApi) {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      return const AuthTokens(
        accessToken: 'mock_access_token_refreshed',
        refreshToken: 'mock_refresh_token',
      );
    }

    try {
      final response = await _apiClient.post<Map<String, dynamic>>(
        ApiEndpoints.refreshToken,
        data: {'refreshToken': refreshToken},
      );
      return AuthTokens.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }
}
