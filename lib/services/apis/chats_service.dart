import 'package:moleculis/models/chat/chat_model.dart';
import 'package:moleculis/models/chat/message_model.dart';
import 'package:moleculis/models/enums/chat_type.dart';
import 'package:moleculis/models/group.dart';
import 'package:moleculis/models/user/user.dart';

abstract class ChatsService {
  Stream<ChatModel?> chatStream(String chatId);

  Stream<List<MessageModel>> messagesStream(String chatId);

  Future<String> sendMessage({
    required String chatId,
    required MessageModel message,
    required List<String> usersUsernames,
    required ChatType chatType,
    Group? group,
    User? user,
    bool isChatCreated = false,
  });

  Future<void> deleteMessage({
    required String chatId,
    required String messageId,
  });
}
