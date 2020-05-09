import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WidgetUtils {
  static void showErrorSnackbar(
      GlobalKey<ScaffoldState> scaffoldKey, String error) {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(error),
        backgroundColor: Colors.red,
      ),
    );
  }

  static void showSuccessSnackbar(
      GlobalKey<ScaffoldState> scaffoldKey, String error,
      {Duration duration}) {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(error),
        duration: duration ?? Duration(milliseconds: 4000),
        backgroundColor: Colors.green,
      ),
    );
  }

  static void showSnackbar(GlobalKey<ScaffoldState> scaffoldKey, String text) {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  static void showSimpleDialog({
    BuildContext context,
    String title = '',
    VoidCallback onYes,
    VoidCallback onNo,
    String confirmText = 'Ok',
    String cancelText = 'Cancel',
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
                if (onYes != null) {
                  onYes();
                }
              },
              child: Text(
                confirmText,
                style: TextStyle(color: Colors.red),
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
                if (onNo != null) {
                  onNo();
                }
              },
              child: Text(cancelText),
            )
          ],
        );
      },
    );
  }
}
