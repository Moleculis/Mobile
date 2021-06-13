import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:moleculis/models/notification/notification_model.dart';
import 'package:moleculis/screens/notifications/widgets/delete_notification_button.dart';
import 'package:moleculis/screens/notifications/widgets/notification_tile.dart';

class CommonNotificationTile extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final bool isActiveNotification;

  const CommonNotificationTile({
    Key? key,
    required this.notification,
    required this.onTap,
    required this.onDelete,
    this.isActiveNotification = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(notification.id),
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.17,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: NotificationTile(
            isActiveNotification: isActiveNotification,
            notification: notification,
            isRead: notification.isRead,
          ),
        ),
      ),
      // secondaryActions: <Widget>[_deleteIcon(context)],
      secondaryActions: <Widget>[DeleteNotificationButton(onDelete: onDelete)],
    );
  }
}
