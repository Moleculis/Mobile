import 'package:flutter/material.dart';
import 'package:moleculis/common/colors.dart';

class SimpleButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const SimpleButton({
    Key key,
    @required this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
      onPressed: onPressed,
      color: accentColorDark,
    );
  }
}
