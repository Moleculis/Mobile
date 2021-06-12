import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moleculis/utils/convert_utils.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
abstract class MessageModel implements _$MessageModel {
  const MessageModel._();

  factory MessageModel({
    required String id,
    required String creatorId,
    required String text,
    @JsonKey(
      fromJson: ConvertUtils.dateTimeFromTimestampNonNull,
      toJson: ConvertUtils.dateTimeToTimestamp,
    )
        required DateTime createdAt,
    required String chatId,
    @JsonKey(
      fromJson: ConvertUtils.dateTimeFromTimestamp,
      toJson: ConvertUtils.dateTimeToTimestamp,
    )
        DateTime? updatedAt,
    @Default(false)
        bool isDeleted,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  factory MessageModel.sendMessage({
    required String creatorId,
    required String chatId,
    required String text,
  }) {
    return MessageModel(
      id: '',
      creatorId: creatorId,
      createdAt: DateTime.now(),
      text: text,
      isDeleted: false,
      chatId: chatId,
    );
  }
}
