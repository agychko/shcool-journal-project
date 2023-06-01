import 'package:shared_preferences/shared_preferences.dart';

class PreferencesSource {
  final String accessToken = 'access-auth-token';
  final String refreshToken = 'refresh-auth-token';

  Future<SharedPreferences> getPreferences() async {
    return SharedPreferences.getInstance();
  }

  Future<void> setAccessToken(String token) async {
    var preferences = await getPreferences();
    preferences.setString(accessToken, token);
  }

  Future<String?> getAccessToken() async {
    var preferences = await getPreferences();
    return preferences.getString(accessToken);
  }

  Future<void> setRefreshToken(String token) async {
    var preferences = await getPreferences();
    preferences.setString(refreshToken, token);
  }

  Future<String?> getRefreshToken() async {
    var preferences = await getPreferences();
    return preferences.getString(refreshToken);
  }
}
