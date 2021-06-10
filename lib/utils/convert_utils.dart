import 'package:cloud_firestore/cloud_firestore.dart';

class ConvertUtils {
  static Timestamp? dateTimeToTimestamp(DateTime? date) {
    return date != null ? Timestamp.fromDate(date) : null;
  }

  static DateTime? dateTimeFromTimestamp(dynamic timestamp) {
    if (timestamp is int) {
      return DateTime.fromMillisecondsSinceEpoch(timestamp);
    }
    return timestamp?.toDate();
  }

  static DateTime dateTimeFromTimestampNonNull(dynamic timestamp) {
    if (timestamp is int) {
      return DateTime.fromMillisecondsSinceEpoch(timestamp);
    }
    return timestamp.toDate();
  }

  static DateTime? returnDateTime(DateTime? dateTime) => dateTime;
}
