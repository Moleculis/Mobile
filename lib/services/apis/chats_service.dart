import 'package:moleculis/models/chat/chat_model.dart';
import 'package:moleculis/models/chat/message_model.dart';
import 'package:moleculis/models/enums/chat_type.dart';

abstract class ChatsService {
  Stream<ChatModel?> chatStream(String chatId);

  Stream<List<MessageModel>> messagesStream(String chatId);

  Future<String> sendMessage({
    required String chatId,
    required MessageModel message,
    required List<String> usersIds,
    required ChatType chatType,
    String? groupId,
    bool isChatCreated = false,
  });

  Future<void> deleteMessage({
    required String chatId,
    required String messageId,
  });
}
