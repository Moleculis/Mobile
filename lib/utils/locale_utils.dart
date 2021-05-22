import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:moleculis/common/img.dart';
import 'package:moleculis/storage/shared_pref_manager.dart';
import 'package:moleculis/utils/locator.dart';

class LocaleUtils {
  static final String localePath = 'assets/locales';

  static final defaultLocale = localeItems.first.locale;

  static final List<Locale> locales = [
    localeItems[0].locale,
    localeItems[1].locale,
  ];

  static final List<LocaleItem> localeItems = [
    LocaleItem(
      locale: Locale(LanguageCodes.en.text, 'US'),
      name: 'English',
      imageAsset: Img.usFlag,
    ),
    LocaleItem(
      locale: Locale(LanguageCodes.uk.text),
      name: 'Українська',
      imageAsset: Img.uaFlag,
    ),
  ];

  static LocaleItem currentLocaleItem(BuildContext context) {
    return localeItems.firstWhere((element) =>
        element.locale.languageCode == context.locale.languageCode);
  }

  static LocaleItem localeFlag(Locale locale) {
    return localeItems.firstWhere(
      (element) => element.locale.languageCode == locale.languageCode,
    );
  }

  static Locale localeFromCode(String? langCode) {
    switch (langCode) {
      case 'en':
        return localeItems.first.locale;
      case 'uk':
        return localeItems[1].locale;
    }
    return defaultLocale;
  }

  static Future<void> setLocale(BuildContext context, Locale locale) async {
    if (!locales.contains(locale)) return;
    locator<SharedPrefManager>().saveCurrentLocale(locale);
    await context.setLocale(locale);
  }
}

enum LanguageCodes { en, uk }

extension LanguageCodesExtension on LanguageCodes {
  String get text {
    switch (this) {
      case LanguageCodes.en:
        return 'en';
      case LanguageCodes.uk:
        return 'uk';
    }
  }
}

class LocaleItem {
  final Locale locale;
  final String name;
  final String imageAsset;

  LocaleItem({
    required this.locale,
    required this.name,
    required this.imageAsset,
  });
}
