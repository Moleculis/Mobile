import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moleculis/models/enums/enum_parser.dart';
import 'package:moleculis/models/enums/notification_type.dart';
import 'package:moleculis/utils/convert_utils.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

enum PushNotificationConfigureType {
  message,
  launch,
  resume,
}

@freezed
abstract class NotificationModel with _$NotificationModel {
  factory NotificationModel({
    required String id,
    required String creatorUsername,
    required String receiverUsername,
    required String title,
    required String text,
    @JsonKey(
      toJson: EnumParser.toStringValue,
      fromJson: notificationTypeFromString,
    )
        required NotificationType notificationType,
    @JsonKey(
      toJson: ConvertUtils.dateTimeToTimestamp,
      fromJson: ConvertUtils.dateTimeFromTimestampNonNull,
    )
        required DateTime createdAt,
    @Default(false)
        bool isRead,
    String? valueName,
    String? valueId,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}
