import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';
import 'package:moleculis/utils/extensions/date_time_extension.dart';

class ProjectDateUtils {
  static String formatDate(String pattern, DateTime date) {
    String formattedDate = DateFormat(pattern).format(date);
    final index = pattern.indexOf('M');
    if (index != -1) {
      formattedDate = '${formattedDate.substring(0, index)}'
          '${formattedDate[index].toUpperCase()}'
          '${formattedDate.substring(index + 1)}';
    }
    return formattedDate.replaceAll('.', '');
  }

  static String formatDateRange(DateTime? fromDate, DateTime? toDate) {
    final String toDateFormat = 'd MMM, yyyy';
    if (toDate == null) {
      return DateFormat(toDateFormat).format(fromDate!);
    } else {
      String fromDateFormat = 'd';
      if (fromDate!.year != toDate.year) {
        fromDateFormat += ' MMM, yyyy';
      } else if (fromDate.month != toDate.month) {
        fromDateFormat += ' MMM';
      }
      final bool needsSpace = fromDateFormat != 'd';
      final String dash = needsSpace ? ' - ' : '-';

      return '${DateFormat(fromDateFormat).format(fromDate)}'
          '$dash${DateFormat(toDateFormat).format(toDate)}';
    }
  }

  static String formatDateTime(DateTime dateTime) {
    return DateFormat('dd MMMM, yyyy').format(dateTime);
  }

  static String getDateDividerString(DateTime date) {
    final dateFormatPattern =
        date.isSameYear(DateTime.now()) ? 'dd MMMM' : 'dd MMMM, yyyy';
    String dividerText = DateFormat(dateFormatPattern).format(date);
    if (date.isSameDay(DateTime.now())) {
      dividerText = 'today'.tr();
    } else if (date.isYesterday) {
      dividerText = 'yesterday'.tr();
    }
    return dividerText;
  }
}
