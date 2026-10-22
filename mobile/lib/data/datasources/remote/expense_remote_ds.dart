import 'package:dio/dio.dart';
import 'package:vehiclehub_pakistan/core/config/app_config.dart';
import 'package:vehiclehub_pakistan/core/network/api_client.dart';
import 'package:vehiclehub_pakistan/core/network/api_endpoints.dart';
import 'package:vehiclehub_pakistan/core/network/api_exception.dart';
import 'package:vehiclehub_pakistan/data/mock/mock_data.dart';
import 'package:vehiclehub_pakistan/data/models/api_response.dart';
import 'package:vehiclehub_pakistan/data/models/expense.dart';

class ExpenseRemoteDataSource {
  ExpenseRemoteDataSource({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<List<Expense>> getExpenses() async {
    if (AppConfig.useMockApi) {
      await Future<void>.delayed(const Duration(milliseconds: 300));
      return List<Expense>.from(MockData.expenses);
    }

    try {
      final response = await _apiClient.get<List<dynamic>>(ApiEndpoints.expenses);
      return (response.data ?? [])
          .map((e) => Expense.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<List<ChartPoint>> getMonthlySpend() async {
    if (AppConfig.useMockApi) {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      return List<ChartPoint>.from(MockData.monthlySpend);
    }

    try {
      final response = await _apiClient.get<List<dynamic>>(
        '${ApiEndpoints.expenses}/monthly',
      );
      return (response.data ?? [])
          .map((e) => ChartPoint.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<List<CategorySpend>> getCategorySpend() async {
    if (AppConfig.useMockApi) {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      return List<CategorySpend>.from(MockData.categorySpend);
    }

    try {
      final response = await _apiClient.get<List<dynamic>>(
        '${ApiEndpoints.expenses}/categories',
      );
      return (response.data ?? [])
          .map((e) => CategorySpend.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<Expense> createExpense(Map<String, dynamic> payload) async {
    if (AppConfig.useMockApi) {
      await Future<void>.delayed(const Duration(milliseconds: 300));
      return Expense.fromJson({
        'id': 'e${MockData.expenses.length + 1}',
        ...payload,
      });
    }

    try {
      final response = await _apiClient.post<Map<String, dynamic>>(
        ApiEndpoints.expenses,
        data: payload,
      );
      return Expense.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }
}
