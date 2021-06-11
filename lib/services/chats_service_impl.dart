import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moleculis/models/chat/chat_model.dart';
import 'package:moleculis/models/chat/message_model.dart';
import 'package:moleculis/models/enums/chat_type.dart';
import 'package:moleculis/services/apis/chats_service.dart';
import 'package:moleculis/utils/convert_utils.dart';

class ChatsServiceImpl implements ChatsService {
  final _chatCollection = FirebaseFirestore.instance.collection('chats');

  final _createdAt = 'createdAt';
  final _isDeleted = 'isDeleted';
  final _updatedAt = 'updatedAt';

  @override
  Stream<List<MessageModel>> messagesStream(String chatId) {
    return _chatCollection
        .doc(chatId)
        .collection('messages')
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
    return _chatCollection.doc(chatId).snapshots().map((documentSnapshot) {
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
    required List<String> usersIds,
    required ChatType chatType,
    String? groupId,
    bool isChatCreated = false,
  }) async {
    final chatDoc = _chatCollection.doc(chatId);
    if (!isChatCreated) {
      await chatDoc.set(ChatModel(
        id: chatId,
        usersIds: usersIds,
        groupId: groupId,
        chatType: chatType,
        onlineUsersIds: [],
      ).toJson());
    }
    final messageDoc = chatDoc.collection('messages').doc();
    await messageDoc.set(message.copyWith(id: messageDoc.id).toJson());
    return messageDoc.id;
  }

  @override
  Future<void> deleteMessage({
    required String chatId,
    required String messageId,
  }) async {
    final messageDoc =
        _chatCollection.doc(chatId).collection('messages').doc(messageId);
    await messageDoc.update({
      _isDeleted: true,
      _updatedAt: ConvertUtils.dateTimeToTimestamp(DateTime.now()),
    });
  }
}
