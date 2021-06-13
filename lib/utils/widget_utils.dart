import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

typedef ShowSnackBar = void Function(String);

class WidgetUtils {
  static Widget loadingIndicator(
    BuildContext context, {
    double width = 4.0,
    bool isAlignCenter = true,
    Color? color,
    double? value,
  }) {
    final indicator = Platform.isIOS
        ? CupertinoActivityIndicator()
        : CircularProgressIndicator(
            value: value,
            valueColor: AlwaysStoppedAnimation<Color>(
              color ?? Theme.of(context).accentColor,
            ),
            strokeWidth: width,
          );
    return isAlignCenter ? Center(child: indicator) : indicator;
  }

  static void showErrorSnackbar(
    BuildContext context, {
    required String error,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
        backgroundColor: Colors.red,
      ),
    );
  }

  static void showSuccessSnackbar(BuildContext context, {
    required String message,
    Duration? duration,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration ?? Duration(milliseconds: 4000),
        backgroundColor: Colors.green,
      ),
    );
  }

  static void showSnackbar(BuildContext context, {
    required String text,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  static void showSimpleDialog({
    required BuildContext context,
    String title = '',
    VoidCallback? onYes,
    VoidCallback? onNo,
    String confirmText = 'Ok',
    String? cancelText,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          actions: <Widget>[
            TextButton(
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
            TextButton(
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

  static Widget backButton(BuildContext context) {
    if (Platform.isAndroid) {
      return IconButton(
        icon: Icon(Icons.arrow_back),
        padding: EdgeInsets.all(0),
        alignment: Alignment.centerLeft,
        onPressed: () => Navigator.pop(context),
      );
    } else {
      return IconButton(
        icon: Icon(CupertinoIcons.left_chevron),
        padding: EdgeInsets.all(0),
        alignment: Alignment.centerLeft,
        onPressed: () => Navigator.pop(context),
      );
    }
  }

  static PreferredSizeWidget appBar(BuildContext context, {
    required String title,
    List<Widget>? actions,
    Color? backgroundColor,
    TabBar? bottom,
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
          backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
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

  static AppBar simpleAppBar(
    BuildContext context, {
    List<Widget>? actions,
    Widget? leading,
    Widget? title,
    Color? iconColor,
    bool centerTitle = false,
    Brightness brightness = Brightness.light,
    double titleSpacing = 16.0,
    bool automaticallyImplyLeading = true,
  }) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      titleSpacing: titleSpacing,
      elevation: 0.0,
      brightness: brightness,
      backgroundColor: Colors.transparent,
      leading: leading,
      actions: actions,
      centerTitle: centerTitle,
      title: title,
      iconTheme: iconColor == null ? null : IconThemeData(color: iconColor),
    );
  }

  static Future<void> showAlertDialog({
    required BuildContext context,
    required String titleKey,
    String? content,
    String submitTextKey = 'ok',
    String refuseText = 'cancel',
    bool isShowCancelButton = true,
    Color? titleColor,
    Color? submitTextColor,
    VoidCallback? onCancel,
    VoidCallback? onSubmit,
    VoidCallback? onDismiss,
    bool barrierDismissible = false,
  }) async {
    if (Platform.isIOS) {
      await showCupertinoDialog(
        context: context,
        useRootNavigator: true,
        barrierDismissible: barrierDismissible,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(titleKey.tr()),
            ),
            content: content == null ? null : Text(content.tr()),
            actions: <Widget>[
              if (isShowCancelButton)
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.pop(context);
                    if (onCancel != null) onCancel();
                  },
                  isDefaultAction: true,
                  child: Text(refuseText.tr()),
                ),
              CupertinoDialogAction(
                onPressed: onSubmit ?? () => Navigator.pop(context),
                child: Text(
                  submitTextKey.tr(),
                  style: TextStyle(color: submitTextColor),
                ),
              )
            ],
          );
        },
      );
    } else {
      await showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              titleKey.tr(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: content == null
                ? null
                : Text(
                    content.tr(),
                    style: TextStyle(color: Colors.grey[800]),
                  ),
            actions: <Widget>[
              if (isShowCancelButton)
                TextButton(
                  child: Text(
                    refuseText.tr(),
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    if (onCancel != null) onCancel();
                  },
                ),
              TextButton(
                child: Text(
                  submitTextKey.tr(),
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: onSubmit ?? () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
    }
    onDismiss?.call();
  }
}
