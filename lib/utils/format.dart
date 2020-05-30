import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:moleculis/utils/locale_utils.dart';

class FormatUtils {

  static String dateFormatString(BuildContext context) {
    String dateFormatString;
    final String languageCode = context.locale.languageCode;
    if (languageCode == LanguageCodes.en.text) {
      dateFormatString = 'MM-dd-yyyy';
    } else if (languageCode == LanguageCodes.uk.text) {
      dateFormatString = 'dd-MM-yyyy';
    }
    return dateFormatString;
  }

  static String formatDateAndTime(DateTime date, BuildContext context) {
    return DateFormat('${dateFormatString(context)} – kk:mm').format(date);
  }

  static String formatDateTime(DateTime date) {
    return DateFormat('yyyy-MM-ddTkk:mm').format(date);
  }

  static String formatDate(DateTime date, BuildContext context) {
    return DateFormat(dateFormatString(context)).format(date);
  }

  static String formatTime(DateTime date) {
    return DateFormat('kk:mm').format(date);
  }
}
