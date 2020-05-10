import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:moleculis/common/img.dart';

class LocaleUtils {
  static final String localePath = 'assets/locales';
  static final List<Locale> locales = [
    localeItems[0].locale,
    localeItems[1].locale,
  ];

  static final List<LocaleItem> localeItems = [
    LocaleItem(
        locale: Locale('en', 'US'), name: 'English', imageAsset: Img.usFlag),
    LocaleItem(locale: Locale('uk'), name: 'Ukrainian', imageAsset: Img.uaFlag),
  ];

  static LocaleItem currentLocaleItem(BuildContext context) {
    return localeItems.firstWhere((element) =>
    element.locale.languageCode == context.locale.languageCode);
  }

  static LocaleItem localeFlag(Locale locale) {
    return localeItems.firstWhere(
            (element) => element.locale.languageCode == locale.languageCode);
  }
}

class LocaleItem {
  final Locale locale;
  final String name;
  final String imageAsset;

  LocaleItem({
    this.locale,
    this.name,
    this.imageAsset,
  });
}
