import 'package:dio/dio.dart';

sealed class ApiException implements Exception {
  const ApiException({required this.message, this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => 'ApiException($statusCode): $message';

  factory ApiException.fromDio(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    String message;
    if (data is Map<String, dynamic>) {
      message = data['message'] as String? ??
          data['error'] as String? ??
          error.message ??
          'Network error';
    } else if (data is String && data.isNotEmpty) {
      message = data;
    } else {
      message = switch (error.type) {
        DioExceptionType.connectionTimeout ||
        DioExceptionType.sendTimeout ||
        DioExceptionType.receiveTimeout =>
          'Connection timed out',
        DioExceptionType.connectionError => 'Network error',
        DioExceptionType.cancel => 'Request cancelled',
        _ => error.message ?? 'Something went wrong',
      };
    }

    final code = statusCode;
    if (code == 401) {
      return UnauthorizedException(message: message, statusCode: code);
    }
    if (code == 403) {
      return ForbiddenException(message: message, statusCode: code);
    }
    if (code == 404) {
      return NotFoundException(message: message, statusCode: code);
    }
    if (code != null && code >= 500 && code < 600) {
      return ServerException(message: message, statusCode: code);
    }
    return NetworkException(message: message, statusCode: code);
  }
}

final class NetworkException extends ApiException {
  const NetworkException({required super.message, super.statusCode});
}

final class UnauthorizedException extends ApiException {
  const UnauthorizedException({required super.message, super.statusCode});
}

final class ForbiddenException extends ApiException {
  const ForbiddenException({required super.message, super.statusCode});
}

final class NotFoundException extends ApiException {
  const NotFoundException({required super.message, super.statusCode});
}

final class ServerException extends ApiException {
  const ServerException({required super.message, super.statusCode});
}
