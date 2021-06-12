import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moleculis/blocs/auth/auth_bloc.dart';
import 'package:moleculis/models/chat/message_model.dart';
import 'package:moleculis/models/chat/messages_group_model.dart';
import 'package:moleculis/models/user/user_small.dart';
import 'package:moleculis/utils/locator.dart';
import 'package:moleculis/utils/project_date_utils.dart';
import 'package:moleculis/utils/widget_utils.dart';
import 'package:moleculis/widgets/user_avatar.dart';

class MessagesGroupWidget extends StatelessWidget {
  final MessagesGroupModel messagesGroup;
  final UserSmall? messageCreator;
  final ValueChanged<MessageModel> onDelete;

  const MessagesGroupWidget({
    Key? key,
    required this.messagesGroup,
    required this.onDelete,
    required this.messageCreator,
  }) : super(key: key);

  void _onLongTap(BuildContext context, MessageModel message) {
    final currentUserUsername = locator<AuthBloc>().state.currentUser!.username;
    final isCurrentUserMessageCreator =
        messagesGroup.groupCreatorUsername == currentUserUsername;
    if (isCurrentUserMessageCreator) {
      WidgetUtils.showAlertDialog(
        context: context,
        title: 'delete_this_message',
        submitText: 'delete',
        submitTextColor: Colors.red,
        onSubmit: () {
          Navigator.pop(context);
          onDelete(message);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isCurrentUserMessageCreator = messagesGroup.groupCreatorUsername ==
        locator<AuthBloc>().state.currentUser!.username;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: isCurrentUserMessageCreator
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          _dateDivider(),
          ...messagesGroup.messagesGroup.map((message) {
            final isLatestMessages =
                message.createdAt == messagesGroup.messagesGroup.last.createdAt;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: isCurrentUserMessageCreator
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                if (!isCurrentUserMessageCreator)
                  _messageCreatorAvatar(context, isLatestMessages),
                _messageWidget(
                  context,
                  message: message,
                  isLatestMessages: isLatestMessages,
                  isCurrentUserMessageCreator: isCurrentUserMessageCreator,
                ),
                if (isCurrentUserMessageCreator)
                  _messageCreatorAvatar(context, isLatestMessages),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _messageWidget(
    BuildContext context, {
    required MessageModel message,
    required bool isCurrentUserMessageCreator,
    required bool isLatestMessages,
  }) {
    final isOldestMessages =
        message.createdAt == messagesGroup.messagesGroup.first.createdAt;
    final mediaQuerySize = MediaQuery.of(context).size;
    return GestureDetector(
      onLongPress: () => _onLongTap(context, message),
      child: Container(
        padding: EdgeInsets.fromLTRB(
          13,
          6,
          isCurrentUserMessageCreator ? 13 : 8,
          6,
        ),
        margin: EdgeInsets.fromLTRB(
          10.0,
          isOldestMessages ? 0.0 : 2.0,
          10.0,
          isLatestMessages ? 0.0 : 2.0,
        ),
        constraints: BoxConstraints(
          maxWidth: mediaQuerySize.width * 0.7,
        ),
        decoration: BoxDecoration(
          borderRadius: _calculateBorderRadius(
            isLatestMessage: isLatestMessages,
            isCurrentUserMessageCreator: isCurrentUserMessageCreator,
          ),
          color: isCurrentUserMessageCreator
              ? Theme.of(context).accentColor
              : Colors.blue,
        ),
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isOldestMessages && !isCurrentUserMessageCreator)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Text(
                          messageCreator!.displayName,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    Text(
                      message.text,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  DateFormat('HH:mm').format(message.createdAt),
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _messageCreatorAvatar(BuildContext context, bool isLatestMessages) {
    if (!isLatestMessages) return SizedBox(width: 29.0);
    return UserAvatar(
      user: messageCreator,
      hasBorder: false,
      hasInnerBorder: false,
      maxRadius: 29.0,
    );
  }

  Widget _dateDivider() {
    final date = messagesGroup.date;
    if (date == null) return Container();
    final dividerText = ProjectDateUtils.getDateDividerString(date);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Text(dividerText),
      ),
    );
  }

  BorderRadius _calculateBorderRadius({
    required bool isCurrentUserMessageCreator,
    required bool isLatestMessage,
  }) {
    final radius = 10.0;
    final isRoundBottomRightCorner =
        !isLatestMessage || !isCurrentUserMessageCreator;
    final isRoundBottomLeftCorner =
        !isLatestMessage || isCurrentUserMessageCreator;
    return BorderRadius.only(
      topLeft: Radius.circular(radius),
      topRight: Radius.circular(radius),
      bottomLeft: Radius.circular(isRoundBottomLeftCorner ? radius : 0.0),
      bottomRight: Radius.circular(isRoundBottomRightCorner ? radius : 0.0),
    );
  }
}
