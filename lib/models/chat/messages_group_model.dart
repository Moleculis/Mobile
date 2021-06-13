import 'package:moleculis/models/chat/message_model.dart';

class MessagesGroupModel {
  final List<MessageModel> messagesGroup;
  final String groupCreatorUsername;
  final DateTime? date;

  MessagesGroupModel({
    required this.messagesGroup,
    required this.groupCreatorUsername,
    this.date,
  });

  MessagesGroupModel copyWith({
    List<MessageModel>? messagesGroup,
    String? groupCreatorId,
    DateTime? date,
  }) {
    return MessagesGroupModel(
      messagesGroup: messagesGroup ?? this.messagesGroup,
      groupCreatorUsername: groupCreatorId ?? this.groupCreatorUsername,
      date: date ?? this.date,
    );
  }
}
