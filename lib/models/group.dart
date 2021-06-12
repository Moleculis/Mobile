import 'package:moleculis/models/requests/create_update_group_request.dart';
import 'package:moleculis/models/user/user_small.dart';

class Group {
  final int id;
  final String title;
  final String? description;
  final List<UserSmall> users;
  final List<UserSmall> admins;

  Group({
    required this.id,
    required this.title,
    required this.users,
    required this.admins,
    this.description,
  });

  factory Group.fromMap(Map<String, dynamic> map) {
    final List<dynamic> usersDynamic = map['users'] as List;
    final List<UserSmall> users =
        usersDynamic.map((i) => UserSmall.fromMap(i)).toList();

    final List<dynamic> adminsDynamic = map['admins'] as List;
    final List<UserSmall> admins =
        adminsDynamic.map((i) => UserSmall.fromMap(i)).toList();

    return Group(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String?,
      users: users,
      admins: admins,
    );
  }

  Group copyWithRequest(
    CreateUpdateGroupRequest request,
    List<UserSmall> users,
    List<UserSmall> admins,
  ) {
    return copyWith(
      title: request.title,
      description: request.description,
      users: users,
      admins: admins,
    );
  }

  Group copyWith({
    int? id,
    String? title,
    String? description,
    List<UserSmall>? users,
    List<UserSmall>? admins,
  }) {
    return Group(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      users: users ?? this.users,
      admins: admins ?? this.admins,
    );
  }
}
