import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Navigation {
  static Future<dynamic> toScreen({
    @required BuildContext context,
    @required Widget screen,
  }) async {
    return await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => screen,
      ),
    );
  }

  static Future<dynamic> toScreenAndCleanBackStack({
    @required BuildContext context,
    @required Widget screen,
  }) async {
    return await Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => screen,
      ),
      (_) => false,
    );
  }
}
