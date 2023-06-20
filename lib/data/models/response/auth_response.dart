class AuthResponse {
  String? accessToken;
  String? refreshToken;

  AuthResponse({required this.accessToken, required this.refreshToken});

  AuthResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }
}
