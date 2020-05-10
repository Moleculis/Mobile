import 'package:moleculis/models/enums/gender.dart';

class RegisterRequest {
  final String displayName;
  final String fullName;
  final Gender gender;
  final String username;
  final String email;
  final String password;

  RegisterRequest({
    this.displayName,
    this.fullName,
    this.gender,
    this.username,
    this.email,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'displayname': this.displayName,
      'fullname': this.fullName,
      'gender': this.gender.name,
      'username': this.username,
      'email': this.email,
      'password': this.password,
    };
  }
}
