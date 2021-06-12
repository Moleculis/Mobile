import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/cubits/chat_cubit/chat_state.dart';
import 'package:moleculis/models/chat/chat_model.dart';
import 'package:moleculis/models/chat/message_model.dart';
import 'package:moleculis/models/enums/chat_type.dart';
import 'package:moleculis/models/group.dart';
import 'package:moleculis/models/user/user.dart';
import 'package:moleculis/services/apis/chats_service.dart';
import 'package:moleculis/utils/chat_utils.dart';
import 'package:moleculis/utils/locator.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatsService _chatService = locator<ChatsService>();

  StreamSubscription? _chatStreamSubscription;
  StreamSubscription? _messagesStreamSubscription;

  ChatCubit() : super(ChatState());

  bool _messagesStreamInitialized = false;

  void initChatStream({required String chatId}) {
    try {
      _messagesStreamInitialized = false;
      emit(ChatState(isLoading: true));
      _chatStreamSubscription?.cancel();
      _chatStreamSubscription = _chatService.chatStream(chatId).listen((chat) {
        _updateChat(chat);
      });
    } catch (e, s) {
      emit(AlbumChatFailure(error: e.toString(), stacktrace: s));
    }
  }

  void _updateChat(ChatModel? chat) async {
    try {
      emit(state.copyWith(chat: chat));
      if (!_messagesStreamInitialized) {
        if (chat != null) {
          runZonedGuarded(() {
            _messagesStreamSubscription?.cancel();
            _messagesStreamSubscription =
                _chatService.messagesStream(chat.id).listen((messages) {
              _updateChatMessages(messages, chat.id);
            });
          }, (_, __) {
            // Will get here if the chat just has been created but the messages
            // sub collection has not
          });
        } else {
          emit(state.copyWith(isLoading: false));
        }
      }
    } catch (e, s) {
      emit(AlbumChatFailure(error: e.toString(), stacktrace: s));
    }
  }

  Future<void> _updateChatMessages(
    List<MessageModel> messages,
    String chatId,
  ) async {
    try {
      _messagesStreamInitialized = true;
      final messagesGroups =
          ChatUtils.divideMessagesByDateAndCreatorId(messages);
      emit(state.copyWith(isLoading: false, messagesGroups: messagesGroups));
    } catch (e, s) {
      emit(AlbumChatFailure(error: e.toString(), stacktrace: s));
    }
  }

  void sendMessage({
    required String chatId,
    required List<String> usersUsernames,
    required ChatType chatType,
    required MessageModel message,
    required bool chatCreated,
    Group? group,
    User? user,
  }) async {
    try {
      await _chatService.sendMessage(
        chatId: chatId,
        message: message,
        usersUsernames: usersUsernames,
        isChatCreated: chatCreated,
        chatType: chatType,
        group: group,
        user: user,
      );
      if (state.chat?.id == null) {
        initChatStream(chatId: chatId);
      }
    } catch (e, s) {
      emit(AlbumChatFailure(error: e.toString(), stacktrace: s));
    }
  }

  void deleteMessage({
    required String chatId,
    required MessageModel message,
  }) async {
    try {
      await _chatService.deleteMessage(
        chatId: chatId,
        messageId: message.id,
      );
    } catch (e, s) {
      emit(AlbumChatFailure(error: e.toString(), stacktrace: s));
    }
  }

  @override
  Future<void> close() {
    _chatStreamSubscription?.cancel();
    _messagesStreamSubscription?.cancel();
    return super.close();
  }
}
