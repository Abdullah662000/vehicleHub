import 'package:dio/dio.dart';
import 'package:vehiclehub_pakistan/core/config/app_config.dart';
import 'package:vehiclehub_pakistan/core/network/api_client.dart';
import 'package:vehiclehub_pakistan/core/network/api_endpoints.dart';
import 'package:vehiclehub_pakistan/core/network/api_exception.dart';
import 'package:vehiclehub_pakistan/data/mock/mock_data.dart';
import 'package:vehiclehub_pakistan/data/models/service_record.dart';
import 'package:vehiclehub_pakistan/data/models/vehicle.dart';

class VehicleRemoteDataSource {
  VehicleRemoteDataSource({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<List<Vehicle>> getVehicles() async {
    if (AppConfig.useMockApi) {
      await Future<void>.delayed(const Duration(milliseconds: 300));
      return List<Vehicle>.from(MockData.vehicles);
    }

    try {
      final response = await _apiClient.get<List<dynamic>>(ApiEndpoints.vehicles);
      return (response.data ?? [])
          .map((e) => Vehicle.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<Vehicle> getVehicle(String id) async {
    if (AppConfig.useMockApi) {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      return MockData.vehicles.firstWhere((v) => v.id == id);
    }

    try {
      final response = await _apiClient.get<Map<String, dynamic>>(
        ApiEndpoints.vehicle(id),
      );
      return Vehicle.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<List<ServiceRecord>> getServiceTimeline(String vehicleId) async {
    if (AppConfig.useMockApi) {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      return List<ServiceRecord>.from(MockData.serviceTimeline);
    }

    try {
      final response = await _apiClient.get<List<dynamic>>(
        '${ApiEndpoints.vehicle(vehicleId)}/service-history',
      );
      return (response.data ?? [])
          .map((e) => ServiceRecord.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<Vehicle> createVehicle(Map<String, dynamic> payload) async {
    if (AppConfig.useMockApi) {
      await Future<void>.delayed(const Duration(milliseconds: 300));
      return Vehicle.fromJson({
        'id': 'v${MockData.vehicles.length + 1}',
        'photo': 'corolla',
        'health': 100,
        'insurance': 'active',
        'color': '#1B4DFF',
        ...payload,
      });
    }

    try {
      final response = await _apiClient.post<Map<String, dynamic>>(
        ApiEndpoints.vehicles,
        data: payload,
      );
      return Vehicle.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }
}
