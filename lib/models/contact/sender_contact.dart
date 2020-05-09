import 'package:moleculis/models/user/user_small.dart';

class SenderContact {
  final bool accepted;
  final UserSmall receiver;

  SenderContact({this.accepted, this.receiver});

  factory SenderContact.fromMap(Map<String, dynamic> map) {
    return SenderContact(
      accepted: map['accepted'] as bool,
      receiver: UserSmall.fromMap(map['receiver']),
    );
  }
}
