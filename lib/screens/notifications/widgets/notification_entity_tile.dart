import 'package:flutter/material.dart';
import 'package:moleculis/models/notification/notification_model.dart';
import 'package:moleculis/screens/notifications/widgets/common_notification_tile.dart';
import 'package:moleculis/utils/values/colors.dart';

class NotificationEntityTile extends StatelessWidget {
  final NotificationModel notificationEntity;
  final String? label;
  final ValueChanged<NotificationModel> onNotificationTap;
  final ValueChanged<NotificationModel> onDeleteNotification;

  const NotificationEntityTile({
    Key? key,
    required this.notificationEntity,
    required this.onNotificationTap,
    required this.onDeleteNotification,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 8),
            child: Text(
              label!,
              style: TextStyle(
                fontSize: 12,
                color: notificationLabelColor,
              ),
            ),
          ),
        _notificationBody(context),
      ],
    );
  }

  Widget _notificationBody(BuildContext context) {
    return CommonNotificationTile(
      isActiveNotification: !notificationEntity.isRead,
      notification: notificationEntity,
      onTap: () => onNotificationTap.call(notificationEntity),
      onDelete: () => onDeleteNotification.call(notificationEntity),
    );
  }
}
