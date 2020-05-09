import 'package:moleculis/models/contact/receiver_contact.dart';
import 'package:moleculis/models/contact/sender_contact.dart';
import 'package:moleculis/models/event.dart';
import 'package:moleculis/models/group/group.dart';

class User {
  final String displayname;
  final String fullname;
  final String gender;
  final List<Event> events;
  final List<SenderContact> contacts;
  final List<ReceiverContact> contactRequests;
  final String username;
  final String email;
  final List<String> roles;
  final List<Group> groups;
  final List<Group> adminGroups;

  User({
    this.displayname,
    this.fullname,
    this.gender,
    this.events,
    this.contacts,
    this.contactRequests,
    this.username,
    this.email,
    this.roles,
    this.groups,
    this.adminGroups,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    final List<dynamic> eventsDynamic = map['events'] as List;
    final List<Event> events =
        eventsDynamic.map((i) => Event.fromMap(i)).toList();

    final List<dynamic> senderContactsDynamic = map['contacts'] as List;
    final List<SenderContact> senderContacts =
        senderContactsDynamic.map((i) => SenderContact.fromMap(i)).toList();

    final List<dynamic> receiverContactsDynamic =
        map['contactRequests'] as List;
    final List<ReceiverContact> receiverContacts =
        receiverContactsDynamic.map((i) => ReceiverContact.fromMap(i)).toList();

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
      gender: map['gender'] as String,
      events: events,
      contacts: senderContacts,
      contactRequests: receiverContacts,
      username: map['username'] as String,
      email: map['email'] as String,
      roles: List<String>.from(rolesDynamic),
      groups: groups,
      adminGroups: adminGroups,
    );
  }
}
