// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NotificationModel _$_$_NotificationModelFromJson(Map<String, dynamic> json) {
  return _$_NotificationModel(
    id: json['id'] as String,
    creatorUsername: json['creatorUsername'] as String,
    receiverUsername: json['receiverUsername'] as String,
    title: json['title'] as String,
    text: json['text'] as String,
    notificationType:
        notificationTypeFromString(json['notificationType'] as String),
    createdAt: ConvertUtils.dateTimeFromTimestampNonNull(json['createdAt']),
    isRead: json['isRead'] as bool? ?? false,
    valueName: json['valueName'] as String?,
    valueId: json['valueId'] as String?,
  );
}

Map<String, dynamic> _$_$_NotificationModelToJson(
        _$_NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'creatorUsername': instance.creatorUsername,
      'receiverUsername': instance.receiverUsername,
      'title': instance.title,
      'text': instance.text,
      'notificationType': EnumParser.toStringValue(instance.notificationType),
      'createdAt': ConvertUtils.dateTimeToTimestamp(instance.createdAt),
      'isRead': instance.isRead,
      'valueName': instance.valueName,
      'valueId': instance.valueId,
    };
