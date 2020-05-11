class UserSmall {
  final String displayName;
  final String fullName;
  final String username;
  final String email;
  final String gender;
  final List<String> roles;

  UserSmall(
      {this.displayName, this.fullName, this.username, this.email, this.roles, this.gender});

  factory UserSmall.fromMap(Map<String, dynamic> map) {
    final List<dynamic> rolesDynamic = map['roles'] as List;

    return UserSmall(
      displayName: map['displayname'] as String,
      fullName: map['fullname'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      gender: map['gender'] as String,
      roles: List<String>.from(rolesDynamic),
    );
  }
}
