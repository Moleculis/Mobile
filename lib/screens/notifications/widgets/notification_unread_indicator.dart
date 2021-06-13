import 'package:flutter/material.dart';

class NotificationUnreadIndicator extends StatelessWidget {
  final Color color;

  const NotificationUnreadIndicator({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 14.0),
      child: Icon(Icons.brightness_1, color: color, size: 7.0),
    );
  }
}
