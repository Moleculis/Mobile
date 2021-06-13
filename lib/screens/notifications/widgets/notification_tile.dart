import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moleculis/models/notification/notification_model.dart';
import 'package:moleculis/screens/notifications/widgets/notification_text.dart';
import 'package:moleculis/screens/notifications/widgets/notification_unread_indicator.dart';
import 'package:moleculis/widgets/user_avatar.dart';

class NotificationTile extends StatelessWidget {
  final NotificationModel notification;
  final bool isRead;
  final bool isActiveNotification;

  const NotificationTile({
    Key? key,
    required this.notification,
    this.isActiveNotification = false,
    required this.isRead,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double imageRadius = 44;
    return Row(
      children: <Widget>[
        if (!isRead) NotificationUnreadIndicator(color: Colors.yellow),
        UserAvatar(
          maxRadius: imageRadius,
          letterSize: 20.0,
          hasInnerBorder: false,
          hasBorder: false,
        ),
        Expanded(child: _notificationText(context)),
      ],
    );
  }

  Widget _notificationText(BuildContext context) {
    return NotificationText(notification: notification);
  }
}
