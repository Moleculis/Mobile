import 'package:moleculis/models/requests/create_update_event_request.dart';
import 'package:moleculis/models/user/user_small.dart';

class Event {
  final int id;
  final String title;
  final DateTime date;
  final DateTime dateCreated;
  final List<UserSmall> users;
  final String? description;
  final bool? private;
  final String? location;

  Event({
    required this.id,
    required this.title,
    required this.date,
    required this.dateCreated,
    required this.users,
    this.description,
    this.private,
    this.location,
  });

  factory Event.fromMap(Map<String, dynamic> map) {
    final List<dynamic> usersDynamic = map['users'] as List;
    final List<UserSmall> users =
        usersDynamic.map((i) => UserSmall.fromMap(i)).toList();
    return Event(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String?,
      private: map['private'] as bool?,
      date: DateTime.parse(map['date']),
      dateCreated: DateTime.parse(map['dateCreated']),
      location: map['location'] as String?,
      users: users,
    );
  }

  Event copyWithRequest(
    CreateUpdateEventRequest request, {
    List<UserSmall>? users,
  }) {
    return copyWith(
        title: request.title ?? this.title,
        description: request.description ?? this.description,
        date: request.date ?? this.date,
        location: request.location ?? this.location,
        users: users ?? this.users);
  }

  Event copyWith({
    int? id,
    String? title,
    String? description,
    bool? private,
    DateTime? date,
    DateTime? dateCreated,
    String? location,
    List<UserSmall>? users,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      private: private ?? this.private,
      date: date ?? this.date,
      dateCreated: dateCreated ?? this.dateCreated,
      location: location ?? this.location,
      users: users ?? this.users,
    );
  }
}
