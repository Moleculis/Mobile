import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:moleculis/utils/locale_utils.dart';
import 'package:moleculis/widgets/locale_widget.dart';

class LanguagesPopup extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final bool showIcon;
  final BuildContext context;

  const LanguagesPopup({
    Key key,
    this.child,
    this.backgroundColor,
    this.showIcon = true,
    this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      enabled: Platform.isAndroid,
      onSelected: (int index) {
        (this.context ?? context)
            .setLocale(LocaleUtils.localeItems[index].locale);
      },
      itemBuilder: (context) => LocaleUtils.localeItems.map(
        (LocaleItem localeItem) {
          final int index = LocaleUtils.localeItems.indexOf(localeItem);
          return PopupMenuItem(
            value: index,
            child: LocaleWidget(
              localeItem: localeItem,
            ),
          );
        },
      ).toList(),
      icon: showIcon
          ? LocaleWidget(
              localeItem: LocaleUtils.currentLocaleItem(context),
              showLanguageName: false,
            )
          : null,
      child: child,
      color: backgroundColor,
    );
  }
}
