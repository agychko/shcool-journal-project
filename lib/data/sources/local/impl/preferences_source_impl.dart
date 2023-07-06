import 'package:journal/data/sources/local/preferences_source.dart';

class PreferencesSourceImpl extends PreferencesSource {

  @override
  Future<void> setAccessToken(String token) async {
    var preferences = await getPreferences();
    preferences.setString(accessToken, token);
  }

  @override
  Future<String?> getAccessToken() async {
    var preferences = await getPreferences();
    return preferences.getString(accessToken);
  }

  @override
  Future<void> setRefreshToken(String token) async {
    var preferences = await getPreferences();
    preferences.setString(refreshToken, token);
  }

  @override
  Future<String?> getRefreshToken() async {
    var preferences = await getPreferences();
    return preferences.getString(refreshToken);
  }
}
