import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:duty_checker/core/shared_preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _accessTokenKey = 'access_token';
const _refreshTokenKey = 'refresh_token';
const _roleKey = 'user_role';

final tokenStorageProvider = Provider<TokenStorage>((ref) {
  return TokenStorage(ref.watch(sharedPreferencesProvider));
});

class TokenStorage {
  TokenStorage(this._prefs);

  final SharedPreferences _prefs;

  String? get accessToken => _prefs.getString(_accessTokenKey);
  String? get refreshToken => _prefs.getString(_refreshTokenKey);
  String? get role => _prefs.getString(_roleKey);

  bool get isGuardian => role == 'GUARDIAN';

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _prefs.setString(_accessTokenKey, accessToken);
    await _prefs.setString(_refreshTokenKey, refreshToken);
  }

  Future<void> saveRole(String role) async {
    await _prefs.setString(_roleKey, role);
  }

  Future<void> clear() async {
    await _prefs.remove(_accessTokenKey);
    await _prefs.remove(_refreshTokenKey);
    await _prefs.remove(_roleKey);
  }

  bool get hasToken => accessToken != null;
}
