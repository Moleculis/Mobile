import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final String title;
  final Widget icon;
  final VoidCallback onTap;

  const SettingsTile({
    Key key,
    this.title,
    this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                icon,
              ],
            ),
          ),
        ),
        Divider(),
      ],
    );
  }
}
