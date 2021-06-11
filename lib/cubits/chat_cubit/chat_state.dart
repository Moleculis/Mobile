import 'package:meta/meta.dart';
import 'package:moleculis/models/chat/chat_model.dart';
import 'package:moleculis/models/chat/messages_group_model.dart';
import 'package:moleculis/models/user/user.dart';

@immutable
class ChatState {
  final bool isLoading;
  final bool isLoadingMore;
  final ChatModel? chat;
  final List<MessagesGroupModel>? messagesGroups;
  final List<User>? members;
  final bool isChatDeleted;

  ChatState({
    this.isLoading = true,
    this.isLoadingMore = false,
    this.chat,
    this.messagesGroups,
    this.members,
    this.isChatDeleted = false,
  });

  ChatState copyWith({
    bool? isLoading,
    bool? isLoadingMore,
    ChatModel? chat,
    List<MessagesGroupModel>? messagesGroups,
    List<User>? albumMembers,
    bool? isChatDeleted,
  }) {
    return ChatState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      chat: chat ?? this.chat,
      messagesGroups: messagesGroups ?? this.messagesGroups,
      members: albumMembers ?? this.members,
      isChatDeleted: isChatDeleted ?? this.isChatDeleted,
    );
  }
}

class AlbumChatFailure extends ChatState {
  final dynamic exception;
  final StackTrace? stacktrace;
  final String error;

  AlbumChatFailure({
    required this.error,
    this.exception,
    this.stacktrace,
  }) : super();

  @override
  String toString() => 'AlbumChatFailure { error: $error }';
}
