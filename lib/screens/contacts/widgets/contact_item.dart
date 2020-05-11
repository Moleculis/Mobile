import 'package:flutter/material.dart';
import 'package:moleculis/models/contact/contact.dart';
import 'package:moleculis/widgets/simple_tile.dart';

class ContactItem extends StatelessWidget {
  final Contact contact;
  final bool isReceived;
  final void Function(int) onAccept;
  final void Function(int) onRemove;

  const ContactItem({
    Key key,
    @required this.contact,
    this.isReceived = false,
    this.onAccept,
    this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleTile(
      title: contact.user.displayName,
      subtitle: contact.user.username,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (isReceived && !contact.accepted)
            GestureDetector(
              onTap: () => onAccept(contact.id),
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.done,
                  color: Colors.green,
                ),
              ),
            ),
          GestureDetector(
            onTap: () => onRemove(contact.id),
            child: Icon(
              Icons.close,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
