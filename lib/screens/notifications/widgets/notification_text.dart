import 'package:flutter/material.dart';
import 'package:moleculis/models/notification/notification_model.dart';
import 'package:moleculis/utils/notification_utils.dart';
import 'package:moleculis/utils/project_date_utils.dart';

class NotificationText extends StatelessWidget {
  final NotificationModel notification;

  const NotificationText({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = NotificationUtils.translateNotification(notification);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: RichText(
        text: TextSpan(
          text: notification.creatorUsername,
          style: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          children: <TextSpan>[
            TextSpan(
              text: ' ${text![0].toLowerCase()}${text.substring(1)} ',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text:
                  ProjectDateUtils.formatDate('HH:mm', notification.createdAt),
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.grey.withOpacity(0.3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
