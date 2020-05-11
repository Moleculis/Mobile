import 'package:moleculis/models/user/user_small.dart';

class Contact {
  final int id;
  final bool accepted;
  final bool isSender;
  final UserSmall user;

  Contact({this.id, this.accepted, this.user, this.isSender});

  factory Contact.fromMap(Map<String, dynamic> map) {
    final bool receiver = map['sender'] != null;
    return Contact(
      id: map['id'] as int,
      accepted: map['accepted'] as bool,
      isSender: !receiver,
      user: UserSmall.fromMap(receiver ? map['sender'] : map['receiver']),
    );
  }
}
