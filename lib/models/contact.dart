import 'package:moleculis/models/user/user_model.dart';
import 'package:moleculis/models/user/user_small.dart';

class Contact {
  final int id;
  final UserSmall user;
  final bool isSender;
  final bool accepted;
  final UserModel? userModel;

  Contact({
    required this.id,
    required this.user,
    required this.isSender,
    required this.accepted,
    this.userModel,
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

  Contact copyWith({
    int? id,
    UserSmall? user,
    bool? isSender,
    bool? accepted,
    UserModel? userModel,
  }) {
    return Contact(
      id: id ?? this.id,
      user: user ?? this.user,
      isSender: isSender ?? this.isSender,
      accepted: accepted ?? this.accepted,
      userModel: userModel ?? this.userModel,
    );
  }
}
