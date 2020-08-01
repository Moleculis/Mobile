import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:moleculis/common/colors.dart';
import 'package:moleculis/screens/settings/widgets/language_item.dart';
import 'package:moleculis/utils/locale_utils.dart';
import 'package:moleculis/utils/widget_utils.dart';

class ChooseLanguageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: settingsBackgroundColor,
      appBar: WidgetUtils.appBar(
        context,
        title: 'choose_language'.tr(),
        backgroundColor: settingsBackgroundColor,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: LocaleUtils.localeItems.length,
        itemBuilder: (BuildContext context, int index) {
          final LocaleItem localeItem = LocaleUtils.localeItems[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: LanguageItem(
              localeItem: localeItem,
              onTap: () => Navigator.of(context).pop(index),
            ),
          );
        },
      ),
    );
  }
}
