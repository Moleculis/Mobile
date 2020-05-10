import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class WidgetUtils {
  static void showErrorSnackbar(GlobalKey<ScaffoldState> scaffoldKey, String error) {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(error),
        backgroundColor: Colors.red,
      ),
    );
  }

  static void showSuccessSnackbar(GlobalKey<ScaffoldState> scaffoldKey, String error,
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
    String cancelText,
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
              child: Text(
                cancelText ?? 'cancel'.tr(),
                style: TextStyle(color: Colors.green),
              ),
            )
          ],
        );
      },
    );
  }

  static Widget appBar(BuildContext context, {
    String title,
    List<Widget> actions,
    Color backgroundColor,
    TabBar bottom,
  }) {
    return PreferredSize(
      preferredSize: bottom == null
          ? Size.fromHeight(80.0)
          : Size.fromHeight(120.0), // here the desired height
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child: AppBar(
          actionsIconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          titleSpacing: 10,
          textTheme: GoogleFonts.ubuntuTextTheme(),
          title: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: AutoSizeText(
              title,
              maxLines: 1,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor:
          backgroundColor ?? Theme
              .of(context)
              .scaffoldBackgroundColor,
          brightness: Brightness.light,
          centerTitle: false,
          actions: actions,
          bottom: PreferredSize(
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: <Widget>[
                  if (bottom != null) bottom,
                ],
              ),
            ),
            preferredSize: Size.fromHeight(bottom == null ? 20 : 70),
          ),
        ),
      ),
    );
  }
}
