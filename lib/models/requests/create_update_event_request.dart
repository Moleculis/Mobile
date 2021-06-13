import 'package:moleculis/utils/format.dart';

class CreateUpdateEventRequest {
  final String? title;
  final String? description;
  final bool? isPrivate;
  final String? location;
  final DateTime? date;
  final List<String>? usersUsernames;

  CreateUpdateEventRequest({
    this.title,
    this.description,
    this.isPrivate,
    this.location,
    this.date,
    this.usersUsernames,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'description': this.description,
      'isPrivate': this.isPrivate,
      'location': this.location,
      'date': FormatUtils.formatDateTime(this.date!),
      'users': this.usersUsernames,
    };
  }

  CreateUpdateEventRequest copyWith({
    String? title,
    String? description,
    bool? isPrivate,
    String? location,
    DateTime? date,
    List<String>? users,
  }) {
    return CreateUpdateEventRequest(
      title: title ?? this.title,
      description: description ?? this.description,
      isPrivate: isPrivate ?? this.isPrivate,
      location: location ?? this.location,
      date: date ?? this.date,
      usersUsernames: users ?? this.usersUsernames,
    );
  }
}
