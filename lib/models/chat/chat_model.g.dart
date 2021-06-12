// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChatModel _$_$_ChatModelFromJson(Map<String, dynamic> json) {
  return _$_ChatModel(
    id: json['id'] as String,
    chatType: chatTypeFromString(json['chatType'] as String),
    usersUsernames: (json['usersUsernames'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
    groupId: json['groupId'] as String?,
    mutedForUsersIds: (json['mutedForUsersIds'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    onlineUsersIds: (json['onlineUsersIds'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
  );
}

Map<String, dynamic> _$_$_ChatModelToJson(_$_ChatModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chatType': EnumParser.toStringValue(instance.chatType),
      'usersUsernames': instance.usersUsernames,
      'groupId': instance.groupId,
      'mutedForUsersIds': instance.mutedForUsersIds,
      'onlineUsersIds': instance.onlineUsersIds,
    };
