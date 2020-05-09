class LoginResponse {
  final String token;

  LoginResponse({this.token});

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      token: map['token'] as String,
    );
  }
}
