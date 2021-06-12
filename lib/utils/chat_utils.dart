import 'package:moleculis/blocs/auth/auth_bloc.dart';
import 'package:moleculis/models/chat/message_model.dart';
import 'package:moleculis/models/chat/messages_group_model.dart';
import 'package:moleculis/models/user/user_small.dart';
import 'package:moleculis/utils/extensions/datetime_extension.dart';
import 'package:moleculis/utils/hash_utils.dart';
import 'package:moleculis/utils/locator.dart';
import 'package:moleculis/utils/sort_utils.dart';

class ChatUtils {
  static String getAlbumChatId(String? albumId, String? albumCreatorId) {
    return '$albumId$albumCreatorId';
  }

  static String getUserChatId(UserSmall user) {
    final currentUser = locator<AuthBloc>().state.currentUser!;
    final sortedUsernames = [currentUser.username, user.username]..sort();
    return HashUtils.countHash(sortedUsernames.join());
  }

  static String getGroupChatId(int groupId) {
    return HashUtils.countHash('Group${groupId}Chat');
  }

  static List<MessagesGroupModel> divideMessagesByDateAndCreatorId(
    List<MessageModel> messages,
  ) {
    if (messages.isEmpty) return <MessagesGroupModel>[];
    final result = <MessagesGroupModel>[];
    var subResult = <MessageModel>[];
    for (int i = 0; i < messages.length; i++) {
      if (i == 0) {
        subResult.add(messages.first);
        if (i == messages.length - 1) {
          SortUtils.messages(subResult);
          result.add(MessagesGroupModel(
            messagesGroup: subResult,
            groupCreatorId: subResult.first.creatorId,
          ));
        }
      } else if (messages[i - 1].creatorId == messages[i].creatorId &&
          messages[i - 1].createdAt.isSameDay(messages[i].createdAt)) {
        subResult.add(messages[i]);
        if (i == messages.length - 1) {
          SortUtils.messages(subResult);
          result.add(MessagesGroupModel(
            messagesGroup: subResult,
            groupCreatorId: subResult.first.creatorId,
          ));
        }
      } else {
        SortUtils.messages(subResult);
        result.add(MessagesGroupModel(
          messagesGroup: subResult,
          groupCreatorId: subResult.first.creatorId,
        ));
        subResult = []..add(messages[i]);
        if (i == messages.length - 1) {
          SortUtils.messages(subResult);
          result.add(MessagesGroupModel(
            messagesGroup: subResult,
            groupCreatorId: subResult.first.creatorId,
          ));
        }
      }
    }

    return _divideMessagesGroupByDate(result);
  }

  static List<MessagesGroupModel> _divideMessagesGroupByDate(
      List<MessagesGroupModel> messagesGroups,) {
    if (messagesGroups.isEmpty) return <MessagesGroupModel>[];

    final result = <MessagesGroupModel>[];
    DateTime? tempDate = messagesGroups.first.messagesGroup.first.createdAt;
    for (int i = 0; i < messagesGroups.length; i++) {
      if (i == messagesGroups.length - 1) {
        tempDate = messagesGroups[i].messagesGroup.first.createdAt;
        result.add(messagesGroups[i].copyWith(date: tempDate));
      } else if (!messagesGroups[i + 1]
          .messagesGroup
          .first
          .createdAt
          .isSameDay(tempDate!)) {
        result.add(messagesGroups[i].copyWith(date: tempDate));
        tempDate = messagesGroups[i + 1].messagesGroup.first.createdAt;
      } else {
        result.add(messagesGroups[i]);
      }
    }
    return result;
  }
}
