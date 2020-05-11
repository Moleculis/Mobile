import 'package:flutter/material.dart';

class InfoItem extends StatelessWidget {
  final String title;
  final String content;
  final Widget contentWidget;

  const InfoItem({
    Key key,
    this.title,
    this.content,
    this.contentWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            title,
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: contentWidget ?? Text('$content'),
        ),
      ],
    );
  }
}
