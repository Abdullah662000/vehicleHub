import 'package:dio/dio.dart';
import 'package:vehiclehub_pakistan/core/config/app_config.dart';
import 'package:vehiclehub_pakistan/core/network/api_client.dart';
import 'package:vehiclehub_pakistan/core/network/api_endpoints.dart';
import 'package:vehiclehub_pakistan/core/network/api_exception.dart';

class BookingRemoteDataSource {
  BookingRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  Future<Map<String, dynamic>> createBooking({
    required String mechanicId,
    required String date,
    required String time,
    required String problem,
  }) async {
    if (AppConfig.useMockApi) {
      await Future<void>.delayed(const Duration(milliseconds: 400));
      return {
        'id': 'bk_${DateTime.now().millisecondsSinceEpoch}',
        'mechanicId': mechanicId,
        'date': date,
        'time': time,
        'problem': problem,
        'status': 'confirmed',
      };
    }

    try {
      final response = await _apiClient.dio.post(
        ApiEndpoints.bookings,
        data: {
          'mechanicId': mechanicId,
          'date': date,
          'time': time,
          'problem': problem,
        },
      );
      final data = response.data;
      if (data is Map<String, dynamic> && data['data'] is Map<String, dynamic>) {
        return data['data'] as Map<String, dynamic>;
      }
      return Map<String, dynamic>.from(data as Map);
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }
}
