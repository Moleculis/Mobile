import 'package:flutter/material.dart';
import 'package:moleculis/models/user/user_small.dart';
import 'package:moleculis/utils/string_utils.dart';

class UserLetter extends StatelessWidget {
  final UserSmall? user;
  final double fontSize;
  final Color textColor;

  const UserLetter({
    Key? key,
    required this.user,
    this.fontSize = 20.0,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      StringUtils.getUserInitials(user!.displayName).toUpperCase(),
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: fontSize,
        letterSpacing: 1.6,
        color: textColor,
      ),
    );
  }
}
