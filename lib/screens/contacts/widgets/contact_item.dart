import 'package:flutter/material.dart';
import 'package:moleculis/models/contact.dart';
import 'package:moleculis/screens/user_details/user_details_screen.dart';
import 'package:moleculis/utils/navigation.dart';
import 'package:moleculis/widgets/simple_tile.dart';

class ContactItem extends StatelessWidget {
  final Contact contact;
  final bool isReceived;
  final ValueSetter<int>? onAccept;
  final ValueSetter<int>? onRemove;

  const ContactItem({
    Key? key,
    required this.contact,
    this.isReceived = false,
    this.onAccept,
    this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleTile(
      onTap: () {
        Navigation.toScreen(
          context: context,
          screen: UserDetails(userSmall: contact.user),
        );
      },
      avatarUrl: contact.userModel?.imageUrl,
      title: contact.user.displayName,
      subtitle: contact.user.username,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (isReceived && !contact.accepted)
            GestureDetector(
              onTap: () => onAccept?.call(contact.id),
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.done,
                  color: Colors.green,
                ),
              ),
            ),
          GestureDetector(
            onTap: () => onRemove?.call(contact.id),
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
