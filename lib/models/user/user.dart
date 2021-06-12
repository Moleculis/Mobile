import 'package:moleculis/models/contact.dart';
import 'package:moleculis/models/enums/gender.dart';
import 'package:moleculis/models/group.dart';
import 'package:moleculis/models/requests/update_user_request.dart';

class User {
  final String username;
  final String email;
  final String displayname;
  final String fullname;
  final Gender gender;
  final List<String> roles;
  final List<Contact>? contacts;
  final List<Contact>? contactRequests;
  final List<Group>? groups;
  final List<Group>? adminGroups;

  User({
    required this.username,
    required this.email,
    required this.displayname,
    required this.fullname,
    required this.gender,
    required this.roles,
    this.contacts,
    this.contactRequests,
    this.groups,
    this.adminGroups,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    final List<dynamic> senderContactsDynamic = map['contacts'] as List;
    final List<Contact> senderContacts =
        senderContactsDynamic.map((i) => Contact.fromMap(i)).toList();

    final List<dynamic> receiverContactsDynamic =
        map['contactRequests'] as List;
    final List<Contact> receiverContacts =
        receiverContactsDynamic.map((i) => Contact.fromMap(i)).toList();

    final List<dynamic> rolesDynamic = map['roles'] as List;

    final List<dynamic> groupsDynamic = map['groups'] as List;
    final List<Group> groups =
        groupsDynamic.map((i) => Group.fromMap(i)).toList();

    final List<dynamic> adminGroupsDynamic = map['admin_groups'] as List;
    final List<Group> adminGroups =
        adminGroupsDynamic.map((i) => Group.fromMap(i)).toList();

    return User(
      displayname: map['displayname'] as String,
      fullname: map['fullname'] as String,
      gender: genderFromString(map['gender']),
      contacts: senderContacts,
      contactRequests: receiverContacts,
      username: map['username'] as String,
      email: map['email'] as String,
      roles: List<String>.from(rolesDynamic),
      groups: groups,
      adminGroups: adminGroups,
    );
  }

  User copyWith({
    String? displayname,
    String? fullname,
    Gender? gender,
    List<Contact>? contacts,
    List<Contact>? contactRequests,
    String? username,
    String? email,
    List<String>? roles,
    List<Group>? groups,
    List<Group>? adminGroups,
  }) {
    return User(
      displayname: displayname ?? this.displayname,
      fullname: fullname ?? this.fullname,
      gender: gender ?? this.gender,
      contacts: contacts ?? this.contacts,
      contactRequests: contactRequests ?? this.contactRequests,
      username: username ?? this.username,
      email: email ?? this.email,
      roles: roles ?? this.roles,
      groups: groups ?? this.groups,
      adminGroups: adminGroups ?? this.adminGroups,
    );
  }

  User copyWithRequest(UpdateUserRequest request) {
    return copyWith(
      username: request.username,
      email: request.email,
      displayname: request.displayName,
      fullname: request.fullName,
      gender: request.gender,
    );
  }
}
