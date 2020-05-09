import 'package:moleculis/models/user/user_small.dart';

class Event {
  final int id;
  final String title;
  final String description;
  final bool private;
  final DateTime date;
  final DateTime dateCreated;
  final String location;
  final List<UserSmall> users;

  Event({
    this.id,
    this.title,
    this.description,
    this.private,
    this.date,
    this.dateCreated,
    this.location,
    this.users,
  });

  factory Event.fromMap(Map<String, dynamic> map) {
    final List<dynamic> usersDynamic = map['users'] as List;
    final List<UserSmall> users =
        usersDynamic.map((i) => UserSmall.fromMap(i)).toList();
    return Event(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      private: map['private'] as bool,
      date: DateTime.parse(map['date']),
      dateCreated: DateTime.parse(map['dateCreated']),
      location: map['location'] as String,
      users: users,
    );
  }
}
