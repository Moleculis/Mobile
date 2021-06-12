import 'package:moleculis/models/user/user_small.dart';

class Contact {
  final int id;
  final UserSmall user;
  final bool isSender;
  final bool accepted;

  Contact({
    required this.id,
    required this.user,
    required this.isSender,
    required this.accepted,
  });

  factory Contact.fromMap(Map<String, dynamic> map) {
    final bool receiver = map['sender'] != null;
    return Contact(
      id: map['id'] as int,
      user: UserSmall.fromMap(receiver ? map['sender'] : map['receiver']),
      isSender: !receiver,
      accepted: map['accepted'] as bool,
    );
  }
}
