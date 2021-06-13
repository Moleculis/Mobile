import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:moleculis/blocs/auth/auth_bloc.dart';
import 'package:moleculis/models/chat/chat_model.dart';
import 'package:moleculis/models/chat/message_model.dart';
import 'package:moleculis/models/enums/chat_type.dart';
import 'package:moleculis/models/group.dart';
import 'package:moleculis/models/user/user.dart';
import 'package:moleculis/services/apis/chats_service.dart';
import 'package:moleculis/services/apis/notifications_service.dart';
import 'package:moleculis/utils/convert_utils.dart';
import 'package:moleculis/utils/locator.dart';
import 'package:moleculis/utils/rtdb_utils.dart';
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
        onlineUsersNames: [],
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

  @override
  Future<void> muteAlbumChat(String chatId) async {
    final path = chatsCollection.doc(chatId);
    final userUsername = locator<AuthBloc>().state.currentUser!.username;
    await path.set(
      {
        'mutedForUserNames': FieldValue.arrayUnion([userUsername]),
      },
      SetOptions(merge: true),
    );
  }

  @override
  Future<void> unMuteAlbumChat(String chatId) async {
    final path = chatsCollection.doc(chatId);
    final userUsername = locator<AuthBloc>().state.currentUser!.username;
    await path.set(
      {
        'mutedForUserNames': FieldValue.arrayRemove([userUsername]),
      },
      SetOptions(merge: true),
    );
  }

  final _offlineChatPresence = {'presence': false};

  final _onlineChatPresence = {'presence': true};

  DatabaseReference _chatStatusRtdbRef(String chatId) {
    final userUsername = locator<AuthBloc>().state.currentUser!.username;
    return RtdbUtils.database
        .reference()
        .child('/chatsUsersPresences/$chatId/$userUsername');
  }

  @override
  Future<void> initChatPresence({
    required String chatId,
  }) async {
    final chatStatusRtdbRef = _chatStatusRtdbRef(chatId);

    await chatStatusRtdbRef
        .onDisconnect()
        .update(_offlineChatPresence)
        .then((_) => chatStatusRtdbRef.set(_onlineChatPresence));

    final notificationsService = locator<NotificationsService>();

    notificationsService.readNewMessagesNotifications(chatId: chatId);
  }

  @override
  Future<void> setUserOffline({
    required String chatId,
  }) async {
    await _chatStatusRtdbRef(chatId).update(_offlineChatPresence);
  }
}
