// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MessageModel _$_$_MessageModelFromJson(Map<String, dynamic> json) {
  return _$_MessageModel(
    id: json['id'] as String,
    creatorUsername: json['creatorUsername'] as String,
    text: json['text'] as String,
    createdAt: ConvertUtils.dateTimeFromTimestampNonNull(json['createdAt']),
    chatId: json['chatId'] as String,
    updatedAt: ConvertUtils.dateTimeFromTimestamp(json['updatedAt']),
    isDeleted: json['isDeleted'] as bool? ?? false,
  );
}

Map<String, dynamic> _$_$_MessageModelToJson(_$_MessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'creatorUsername': instance.creatorUsername,
      'text': instance.text,
      'createdAt': ConvertUtils.dateTimeToTimestamp(instance.createdAt),
      'chatId': instance.chatId,
      'updatedAt': ConvertUtils.dateTimeToTimestamp(instance.updatedAt),
      'isDeleted': instance.isDeleted,
    };
