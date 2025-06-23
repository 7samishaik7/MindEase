class AuthResponse {
  final String accessToken;

  AuthResponse({required this.accessToken});

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      AuthResponse(accessToken: json['access_token']);

  Map<String, dynamic> toJson() => {
        'access_token': accessToken,
      };
}
