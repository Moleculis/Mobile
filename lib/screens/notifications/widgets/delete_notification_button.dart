import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:moleculis/screens/notifications/widgets/delete_notification_alert_dialog.dart';

class DeleteNotificationButton extends StatelessWidget {
  final VoidCallback onDelete;

  const DeleteNotificationButton({
    Key? key,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
      height: 33.0,
      width: 33.0,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(33.0)),
          onTap: () {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (_) {
                  return DeleteNotificationAlertDialog(
                    onDelete: () {
                      Navigator.pop(_);
                      onDelete.call();
                    },
                    onCancel: () {
                      Slidable.of(context)!.close();
                      Navigator.pop(_);
                    },
                  );
                });
          },
          child: Center(
              child: Icon(
            Icons.delete,
            size: 16,
            color: Colors.white,
          )),
        ),
      ),
    );
  }
}
