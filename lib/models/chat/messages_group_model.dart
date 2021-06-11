import 'package:moleculis/models/chat/message_model.dart';

class MessagesGroupModel {
  final List<MessageModel> messagesGroup;
  final String groupCreatorId;
  final DateTime? date;

  MessagesGroupModel({
    required this.messagesGroup,
    required this.groupCreatorId,
    this.date,
  });

  MessagesGroupModel copyWith({
    List<MessageModel>? messagesGroup,
    String? groupCreatorId,
    DateTime? date,
  }) {
    return MessagesGroupModel(
      messagesGroup: messagesGroup ?? this.messagesGroup,
      groupCreatorId: groupCreatorId ?? this.groupCreatorId,
      date: date ?? this.date,
    );
  }
}
