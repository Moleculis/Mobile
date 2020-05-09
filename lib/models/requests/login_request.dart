class LoginRequest {
  final String username;
  final String password;

  LoginRequest({
    this.username,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': this.username,
      'password': this.password,
    };
  }
}
