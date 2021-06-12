import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moleculis/models/chat/chat_model.dart';
import 'package:moleculis/models/chat/message_model.dart';
import 'package:moleculis/models/enums/chat_type.dart';
import 'package:moleculis/models/group.dart';
import 'package:moleculis/models/user/user.dart';
import 'package:moleculis/services/apis/chats_service.dart';
import 'package:moleculis/utils/convert_utils.dart';
import 'package:moleculis/utils/values/collections_refs.dart';

class ChatsServiceImpl implements ChatsService {
  final _createdAt = 'createdAt';
  final _isDeleted = 'isDeleted';
  final _updatedAt = 'updatedAt';

  @override
  Stream<List<MessageModel>> messagesStream(String chatId) {
    return chatMessagesCollection(chatId)
        .where(_isDeleted, isEqualTo: false)
        .orderBy(_createdAt, descending: true)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.map((DocumentSnapshot doc) {
        return MessageModel.fromJson(doc.data() as Map<String, dynamic>)
            .copyWith(id: doc.id);
      }).toList();
    });
  }

  @override
  Stream<ChatModel?> chatStream(String chatId) {
    return chatsCollection.doc(chatId).snapshots().map((documentSnapshot) {
      if (documentSnapshot.exists) {
        return ChatModel.fromJson(documentSnapshot.data()!)
            .copyWith(id: documentSnapshot.id);
      }
      return null;
    });
  }

  @override
  Future<String> sendMessage({
    required String chatId,
    required MessageModel message,
    required List<String> usersUsernames,
    required ChatType chatType,
    Group? group,
    User? user,
    bool isChatCreated = false,
  }) async {
    final chatDoc = chatsCollection.doc(chatId);
    if (!isChatCreated) {
      await chatDoc.set(ChatModel(
        id: chatId,
        usersUsernames: usersUsernames,
        groupId: group?.id.toString(),
        chatType: chatType,
        onlineUsersIds: [],
      ).toJson());
    }
    final messageDoc = chatMessagesCollection(chatId).doc();
    await messageDoc.set(message.copyWith(id: messageDoc.id).toJson());
    return messageDoc.id;
  }

  @override
  Future<void> deleteMessage({
    required String chatId,
    required String messageId,
  }) async {
    final messageDoc = chatMessagesCollection(chatId).doc(messageId);
    await messageDoc.update({
      _isDeleted: true,
      _updatedAt: ConvertUtils.dateTimeToTimestamp(DateTime.now()),
    });
  }
}
