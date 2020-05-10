import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:moleculis/utils/locale_utils.dart';
import 'package:moleculis/widgets/locale_widget.dart';

class LanguagesPopup extends StatelessWidget {
  final BuildContext context;

  const LanguagesPopup({Key key, @required this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      onSelected: (int index) {
        this.context.locale = LocaleUtils.localeItems[index].locale;
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
      icon: LocaleWidget(
        localeItem: LocaleUtils.currentLocaleItem(context),
        showLanguageName: false,
      ),
    );
  }
}
