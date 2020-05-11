import 'package:easy_localization/easy_localization.dart';

class FormatUtils {
  static String formatDateAndTime(DateTime date) {
    return DateFormat('yyyy-MM-dd – kk:mm').format(date);
  }

  static String formatDateTime(DateTime date) {
    return DateFormat('yyyy-MM-ddTkk:mm').format(date);
  }

  static String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String formatTime(DateTime date) {
    return DateFormat('kk:mm').format(date);
  }
}
