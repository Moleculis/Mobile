import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moleculis/models/enums/chat_type.dart';
import 'package:moleculis/models/enums/enum_parser.dart';

part 'chat_model.freezed.dart';
part 'chat_model.g.dart';

@freezed
abstract class ChatModel with _$ChatModel {
  factory ChatModel({
    required String id,
    @JsonKey(
      toJson: EnumParser.toStringValue,
      fromJson: chatTypeFromString,
    ) required ChatType chatType,
    required List<String> usersUsernames,
    String? groupId,
    List<String>? mutedForUserNames,
    List<String>? onlineUsersNames,
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);
}
