class UserSmall {
  final String displayName;
  final String username;
  final String email;
  final List<String> roles;

  UserSmall({this.displayName, this.username, this.email, this.roles});

  factory UserSmall.fromMap(Map<String, dynamic> map) {
    final List<dynamic> rolesDynamic = map['roles'] as List;

    return UserSmall(
      displayName: map['displayname'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      roles: List<String>.from(rolesDynamic),
    );
  }
}
