extension DateTimeExtension on DateTime {
  bool isSameDay(DateTime secondDay) {
    return year == secondDay.year &&
        month == secondDay.month &&
        day == secondDay.day;
  }

  bool isSameMonth(DateTime secondDay) {
    return year == secondDay.year && month == secondDay.month;
  }

  bool isSameYear(DateTime secondDay) => year == secondDay.year;

  DateTime get withoutTime => DateTime(year, month, day);

  bool get isYesterday {
    final now = DateTime.now();
    final calculatedDifference = DateTime(year, month, day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
    return calculatedDifference == -1;
  }
}
