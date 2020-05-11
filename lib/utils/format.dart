import 'package:easy_localization/easy_localization.dart';

class FormatUtils {
  static String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd – kk:mm').format(date);
  }
}
