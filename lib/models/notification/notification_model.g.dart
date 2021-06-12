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
    createdAt: DateTime.parse(json['createdAt'] as String),
    isRead: json['isRead'] as bool? ?? false,
    valueName: json['valueName'] as String?,
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
      'createdAt': instance.createdAt.toIso8601String(),
      'isRead': instance.isRead,
      'valueName': instance.valueName,
    };
