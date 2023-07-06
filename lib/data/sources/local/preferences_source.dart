import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PreferencesSource {
  @protected
  final String accessToken = 'access-auth-token';
  @protected
  final String refreshToken = 'refresh-auth-token';

  @protected
  Future<SharedPreferences> getPreferences() async {
    return SharedPreferences.getInstance();
  }

  Future<void> setAccessToken(String token);

  Future<String?> getAccessToken();

  Future<void> setRefreshToken(String token);

  Future<String?> getRefreshToken();
}
