import 'package:moleculis/models/user/user_small.dart';

class Group {
  final String title;
  final String description;
  final List<UserSmall> users;
  final List<UserSmall> admins;

  Group({this.title, this.description, this.users, this.admins});

  factory Group.fromMap(Map<String, dynamic> map) {
    final List<dynamic> usersDynamic = map['users'] as List;
    final List<UserSmall> users =
        usersDynamic.map((i) => UserSmall.fromMap(i)).toList();

    final List<dynamic> adminsDynamic = map['admins'] as List;
    final List<UserSmall> admins =
        adminsDynamic.map((i) => UserSmall.fromMap(i)).toList();

    return Group(
      title: map['title'] as String,
      description: map['description'] as String,
      users: users,
      admins: admins,
    );
  }
}
