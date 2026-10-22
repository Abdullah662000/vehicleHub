import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehiclehub_pakistan/core/network/api_client.dart';
import 'package:vehiclehub_pakistan/core/storage/app_preferences.dart';
import 'package:vehiclehub_pakistan/core/storage/token_storage.dart';
import 'package:vehiclehub_pakistan/data/datasources/remote/auth_remote_ds.dart';
import 'package:vehiclehub_pakistan/data/datasources/remote/booking_remote_ds.dart';
import 'package:vehiclehub_pakistan/data/datasources/remote/expense_remote_ds.dart';
import 'package:vehiclehub_pakistan/data/datasources/remote/mechanic_remote_ds.dart';
import 'package:vehiclehub_pakistan/data/datasources/remote/vehicle_remote_ds.dart';
import 'package:vehiclehub_pakistan/data/models/api_response.dart';
import 'package:vehiclehub_pakistan/data/models/expense.dart';
import 'package:vehiclehub_pakistan/data/models/mechanic.dart';
import 'package:vehiclehub_pakistan/data/models/user.dart';
import 'package:vehiclehub_pakistan/data/models/vehicle.dart';
import 'package:vehiclehub_pakistan/data/repositories/auth_repository.dart';
import 'package:vehiclehub_pakistan/data/repositories/expense_repository.dart';
import 'package:vehiclehub_pakistan/data/repositories/mechanic_repository.dart';
import 'package:vehiclehub_pakistan/data/repositories/vehicle_repository.dart';

// ---------------------------------------------------------------------------
// Core services
// ---------------------------------------------------------------------------

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences must be overridden at startup');
});

final appPreferencesProvider = Provider<AppPreferences>((ref) {
  return AppPreferences(ref.watch(sharedPreferencesProvider));
});

final tokenStorageProvider = Provider<TokenStorage>((ref) {
  return TokenStorage();
});

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient.create(tokenStorage: ref.watch(tokenStorageProvider));
});

// ---------------------------------------------------------------------------
// Remote data sources
// ---------------------------------------------------------------------------

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSource(apiClient: ref.watch(apiClientProvider));
});

final vehicleRemoteDataSourceProvider = Provider<VehicleRemoteDataSource>((ref) {
  return VehicleRemoteDataSource(apiClient: ref.watch(apiClientProvider));
});

final mechanicRemoteDataSourceProvider = Provider<MechanicRemoteDataSource>((ref) {
  return MechanicRemoteDataSource(apiClient: ref.watch(apiClientProvider));
});

final expenseRemoteDataSourceProvider = Provider<ExpenseRemoteDataSource>((ref) {
  return ExpenseRemoteDataSource(apiClient: ref.watch(apiClientProvider));
});

final bookingRemoteDataSourceProvider = Provider<BookingRemoteDataSource>((ref) {
  return BookingRemoteDataSource(ref.watch(apiClientProvider));
});

// ---------------------------------------------------------------------------
// Repositories
// ---------------------------------------------------------------------------

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    remoteDataSource: ref.watch(authRemoteDataSourceProvider),
    tokenStorage: ref.watch(tokenStorageProvider),
    preferences: ref.watch(appPreferencesProvider),
  );
});

final vehicleRepositoryProvider = Provider<VehicleRepository>((ref) {
  return VehicleRepository(
    remoteDataSource: ref.watch(vehicleRemoteDataSourceProvider),
  );
});

final mechanicRepositoryProvider = Provider<MechanicRepository>((ref) {
  return MechanicRepository(
    remoteDataSource: ref.watch(mechanicRemoteDataSourceProvider),
  );
});

final expenseRepositoryProvider = Provider<ExpenseRepository>((ref) {
  return ExpenseRepository(
    remoteDataSource: ref.watch(expenseRemoteDataSourceProvider),
  );
});

// ---------------------------------------------------------------------------
// Theme & locale
// ---------------------------------------------------------------------------

final themeModeProvider =
    StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier(ref.watch(appPreferencesProvider));
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier(this._preferences) : super(_preferences.themeMode);

  final AppPreferences _preferences;

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    await _preferences.setThemeMode(mode);
  }
}

final localeProvider = StateNotifierProvider<LocaleNotifier, String>((ref) {
  return LocaleNotifier(ref.watch(appPreferencesProvider));
});

class LocaleNotifier extends StateNotifier<String> {
  LocaleNotifier(this._preferences) : super(_preferences.locale);

  final AppPreferences _preferences;

  Future<void> setLocale(String locale) async {
    state = locale;
    await _preferences.setLocale(locale);
  }
}

// ---------------------------------------------------------------------------
// Auth state
// ---------------------------------------------------------------------------

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState extends Equatable {
  const AuthState({
    required this.status,
    this.user,
    this.isLoading = false,
    this.errorMessage,
  });

  const AuthState.unknown()
      : this(status: AuthStatus.unknown, isLoading: true);

  const AuthState.unauthenticated()
      : this(status: AuthStatus.unauthenticated);

  const AuthState.authenticated(User user)
      : this(status: AuthStatus.authenticated, user: user);

  final AuthStatus status;
  final User? user;
  final bool isLoading;
  final String? errorMessage;

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
    bool clearUser = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: clearUser ? null : (user ?? this.user),
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [status, user, isLoading, errorMessage];
}

final authStateProvider =
    StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  return AuthStateNotifier(ref.watch(authRepositoryProvider));
});

class AuthStateNotifier extends StateNotifier<AuthState> {
  AuthStateNotifier(this._repository) : super(const AuthState.unknown()) {
    _checkAuth();
  }

  final AuthRepository _repository;

  Future<void> _checkAuth() async {
    try {
      final authenticated = await _repository.isAuthenticated;
      if (authenticated && _repository.currentUser != null) {
        state = AuthState.authenticated(_repository.currentUser!);
      } else if (authenticated) {
        state = const AuthState(
          status: AuthStatus.authenticated,
          isLoading: false,
        );
      } else {
        state = const AuthState.unauthenticated();
      }
    } catch (_) {
      state = const AuthState.unauthenticated();
    }
  }

  Future<void> login({required String email, required String password}) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final user = await _repository.login(email: email, password: password);
      state = AuthState.authenticated(user);
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> signup({
    required String fullName,
    required String email,
    required String password,
    String? phone,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final user = await _repository.signup(
        fullName: fullName,
        email: email,
        password: password,
        phone: phone,
      );
      state = AuthState.authenticated(user);
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> verifyOtp({required String phone, required String code}) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      await _repository.verifyOtp(phone: phone, code: code);
      state = const AuthState(
        status: AuthStatus.authenticated,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    state = const AuthState.unauthenticated();
  }
}

// ---------------------------------------------------------------------------
// Data (async repositories)
// ---------------------------------------------------------------------------

final vehiclesProvider = FutureProvider.autoDispose<List<Vehicle>>((ref) async {
  return ref.watch(vehicleRepositoryProvider).getVehicles();
});

final mechanicsProvider =
    FutureProvider.autoDispose<List<Mechanic>>((ref) async {
  return ref.watch(mechanicRepositoryProvider).getMechanics();
});

final expensesProvider =
    FutureProvider.autoDispose<List<Expense>>((ref) async {
  return ref.watch(expenseRepositoryProvider).getExpenses();
});

final monthlySpendProvider =
    FutureProvider.autoDispose<List<ChartPoint>>((ref) async {
  return ref.watch(expenseRepositoryProvider).getMonthlySpend();
});

final categorySpendProvider =
    FutureProvider.autoDispose<List<CategorySpend>>((ref) async {
  return ref.watch(expenseRepositoryProvider).getCategorySpend();
});
