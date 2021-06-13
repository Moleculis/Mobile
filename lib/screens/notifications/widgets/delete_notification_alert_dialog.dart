import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DeleteNotificationAlertDialog extends StatelessWidget {
  final VoidCallback? onDelete;
  final VoidCallback? onCancel;

  const DeleteNotificationAlertDialog({
    Key? key,
    required this.onDelete,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final radius = Radius.circular(14.0);
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(radius)),
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.symmetric(horizontal: 78.0, vertical: 30.0),
      title: Text(
        'delete_this_notification'.tr(),
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
      ),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        Divider(height: 1.0),
        InkWell(
          onTap: onDelete,
          child: dialogButtonView('delete'.tr(), Colors.red),
        ),
        Divider(height: 1.0),
        InkWell(
          onTap: onCancel,
          borderRadius: BorderRadius.only(
            bottomLeft: radius,
            bottomRight: radius,
          ),
          child: dialogButtonView('cancel'.tr(), primaryColor),
        ),
      ]),
    );
  }

  Widget dialogButtonView(String text, Color color) {
    return Container(
      height: 57.0,
      child: Center(
        child: Text(text, style: TextStyle(color: color, fontSize: 16.0)),
      ),
    );
  }
}
