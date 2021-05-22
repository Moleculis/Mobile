import 'package:moleculis/models/enums/gender.dart';
import 'package:moleculis/models/user/user.dart';

class UserSmall {
  final String displayName;
  final String fullName;
  final String username;
  final String email;
  final Gender gender;
  final List<String> roles;

  UserSmall({
    required this.displayName,
    required this.fullName,
    required this.username,
    required this.email,
    required this.roles,
    required this.gender,
  });

  factory UserSmall.fromMap(Map<String, dynamic> map) {
    final List<dynamic> rolesDynamic = map['roles'] as List;

    return UserSmall(
      displayName: map['displayname'] as String,
      fullName: map['fullname'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      gender: genderFromString(map['gender']),
      roles: List<String>.from(rolesDynamic),
    );
  }

  factory UserSmall.fromUser(User user) {
    return UserSmall(
      displayName: user.displayname,
      fullName: user.fullname,
      username: user.username,
      email: user.email,
      gender: user.gender,
      roles: user.roles,
    );
  }
}
