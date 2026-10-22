import 'package:dio/dio.dart';
import 'package:vehiclehub_pakistan/core/config/app_config.dart';
import 'package:vehiclehub_pakistan/core/network/api_client.dart';
import 'package:vehiclehub_pakistan/core/network/api_endpoints.dart';
import 'package:vehiclehub_pakistan/core/network/api_exception.dart';
import 'package:vehiclehub_pakistan/data/mock/mock_data.dart';
import 'package:vehiclehub_pakistan/data/models/mechanic.dart';

class MechanicRemoteDataSource {
  MechanicRemoteDataSource({required ApiClient apiClient})
      : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<List<Mechanic>> getMechanics({
    double? maxDistance,
    bool verifiedOnly = false,
  }) async {
    if (AppConfig.useMockApi) {
      await Future<void>.delayed(const Duration(milliseconds: 300));
      var results = List<Mechanic>.from(MockData.mechanics);
      if (verifiedOnly) {
        results = results.where((m) => m.verified).toList();
      }
      if (maxDistance != null) {
        results = results.where((m) => m.distance <= maxDistance).toList();
      }
      return results;
    }

    try {
      final response = await _apiClient.get<List<dynamic>>(
        ApiEndpoints.mechanics,
        queryParameters: {
          if (maxDistance != null) 'maxDistance': maxDistance,
          if (verifiedOnly) 'verifiedOnly': verifiedOnly,
        },
      );
      return (response.data ?? [])
          .map((e) => Mechanic.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<Mechanic> getMechanic(String id) async {
    if (AppConfig.useMockApi) {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      return MockData.mechanics.firstWhere((m) => m.id == id);
    }

    try {
      final response = await _apiClient.get<Map<String, dynamic>>(
        ApiEndpoints.mechanic(id),
      );
      return Mechanic.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }
}
