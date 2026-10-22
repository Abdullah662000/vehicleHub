import 'package:vehiclehub_pakistan/data/datasources/remote/expense_remote_ds.dart';
import 'package:vehiclehub_pakistan/data/models/api_response.dart';
import 'package:vehiclehub_pakistan/data/models/expense.dart';

class ExpenseRepository {
  ExpenseRepository({required ExpenseRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  final ExpenseRemoteDataSource _remoteDataSource;

  Future<List<Expense>> getExpenses() => _remoteDataSource.getExpenses();

  Future<List<ChartPoint>> getMonthlySpend() =>
      _remoteDataSource.getMonthlySpend();

  Future<List<CategorySpend>> getCategorySpend() =>
      _remoteDataSource.getCategorySpend();

  Future<Expense> createExpense({
    required String category,
    required String title,
    required int amount,
    required String date,
    required String icon,
  }) {
    return _remoteDataSource.createExpense({
      'category': category,
      'title': title,
      'amount': amount,
      'date': date,
      'icon': icon,
    });
  }
}
