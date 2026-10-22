import 'package:vehiclehub_pakistan/core/storage/app_preferences.dart';
import 'package:vehiclehub_pakistan/core/storage/token_storage.dart';
import 'package:vehiclehub_pakistan/data/datasources/remote/auth_remote_ds.dart';
import 'package:vehiclehub_pakistan/data/models/user.dart';

class AuthRepository {
  AuthRepository({
    required AuthRemoteDataSource remoteDataSource,
    required TokenStorage tokenStorage,
    required AppPreferences preferences,
  })  : _remoteDataSource = remoteDataSource,
        _tokenStorage = tokenStorage,
        _preferences = preferences;

  final AuthRemoteDataSource _remoteDataSource;
  final TokenStorage _tokenStorage;
  final AppPreferences _preferences;

  User? _currentUser;

  User? get currentUser => _currentUser;

  Future<User> login({
    required String email,
    required String password,
  }) async {
    final result = await _remoteDataSource.login(
      email: email,
      password: password,
    );
    await _tokenStorage.saveTokens(
      accessToken: result.tokens.accessToken,
      refreshToken: result.tokens.refreshToken,
    );
    await _preferences.setLoggedIn(true);
    _currentUser = result.user;
    return result.user;
  }

  Future<User> signup({
    required String fullName,
    required String email,
    required String password,
    String? phone,
  }) async {
    final result = await _remoteDataSource.signup(
      fullName: fullName,
      email: email,
      password: password,
      phone: phone,
    );
    await _tokenStorage.saveTokens(
      accessToken: result.tokens.accessToken,
      refreshToken: result.tokens.refreshToken,
    );
    await _preferences.setLoggedIn(true);
    _currentUser = result.user;
    return result.user;
  }

  Future<AuthTokens> verifyOtp({
    required String phone,
    required String code,
  }) async {
    final tokens = await _remoteDataSource.verifyOtp(phone: phone, code: code);
    await _tokenStorage.saveTokens(
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
    );
    await _preferences.setLoggedIn(true);
    return tokens;
  }

  Future<void> resendOtp({required String phone}) {
    return _remoteDataSource.resendOtp(phone: phone);
  }

  Future<AuthTokens> refreshToken() async {
    final refresh = await _tokenStorage.getRefreshToken();
    if (refresh == null || refresh.isEmpty) {
      throw StateError('No refresh token available');
    }
    final tokens = await _remoteDataSource.refreshToken(refreshToken: refresh);
    await _tokenStorage.saveTokens(
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
    );
    return tokens;
  }

  Future<void> logout() async {
    await _tokenStorage.clearTokens();
    await _preferences.clearSession();
    _currentUser = null;
  }

  Future<bool> get isAuthenticated async {
    if (!_preferences.isLoggedIn) return false;
    final token = await _tokenStorage.getAccessToken();
    return token != null && token.isNotEmpty;
  }
}
