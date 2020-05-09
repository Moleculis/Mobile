import 'package:moleculis/models/user/user_small.dart';

class ReceiverContact {
  final bool accepted;
  final UserSmall sender;

  ReceiverContact({this.accepted, this.sender});

  factory ReceiverContact.fromMap(Map<String, dynamic> map) {
    return ReceiverContact(
      accepted: map['accepted'] as bool,
      sender: UserSmall.fromMap(map['sender']),
    );
  }
}
