// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) {
  return _MessageModel.fromJson(json);
}

/// @nodoc
class _$MessageModelTearOff {
  const _$MessageModelTearOff();

  _MessageModel call(
      {required String id,
      required String creatorId,
      required String text,
      @JsonKey(fromJson: ConvertUtils.dateTimeFromTimestampNonNull, toJson: ConvertUtils.dateTimeToTimestamp)
          required DateTime createdAt,
      required String chatId,
      @JsonKey(fromJson: ConvertUtils.dateTimeFromTimestamp, toJson: ConvertUtils.dateTimeToTimestamp)
          DateTime? updatedAt,
      bool isDeleted = false}) {
    return _MessageModel(
      id: id,
      creatorId: creatorId,
      text: text,
      createdAt: createdAt,
      chatId: chatId,
      updatedAt: updatedAt,
      isDeleted: isDeleted,
    );
  }

  MessageModel fromJson(Map<String, Object> json) {
    return MessageModel.fromJson(json);
  }
}

/// @nodoc
const $MessageModel = _$MessageModelTearOff();

/// @nodoc
mixin _$MessageModel {
  String get id => throw _privateConstructorUsedError;

  String get creatorId => throw _privateConstructorUsedError;

  String get text => throw _privateConstructorUsedError;

  @JsonKey(
      fromJson: ConvertUtils.dateTimeFromTimestampNonNull,
      toJson: ConvertUtils.dateTimeToTimestamp)
  DateTime get createdAt => throw _privateConstructorUsedError;

  String get chatId => throw _privateConstructorUsedError;

  @JsonKey(
      fromJson: ConvertUtils.dateTimeFromTimestamp,
      toJson: ConvertUtils.dateTimeToTimestamp)
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  bool get isDeleted => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MessageModelCopyWith<MessageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageModelCopyWith<$Res> {
  factory $MessageModelCopyWith(
          MessageModel value, $Res Function(MessageModel) then) =
      _$MessageModelCopyWithImpl<$Res>;

  $Res call(
      {String id,
      String creatorId,
      String text,
      @JsonKey(fromJson: ConvertUtils.dateTimeFromTimestampNonNull, toJson: ConvertUtils.dateTimeToTimestamp)
          DateTime createdAt,
      String chatId,
      @JsonKey(fromJson: ConvertUtils.dateTimeFromTimestamp, toJson: ConvertUtils.dateTimeToTimestamp)
          DateTime? updatedAt,
      bool isDeleted});
}

/// @nodoc
class _$MessageModelCopyWithImpl<$Res> implements $MessageModelCopyWith<$Res> {
  _$MessageModelCopyWithImpl(this._value, this._then);

  final MessageModel _value;

  // ignore: unused_field
  final $Res Function(MessageModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? creatorId = freezed,
    Object? text = freezed,
    Object? createdAt = freezed,
    Object? chatId = freezed,
    Object? updatedAt = freezed,
    Object? isDeleted = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      creatorId: creatorId == freezed
          ? _value.creatorId
          : creatorId // ignore: cast_nullable_to_non_nullable
              as String,
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      chatId: chatId == freezed
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isDeleted: isDeleted == freezed
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$MessageModelCopyWith<$Res>
    implements $MessageModelCopyWith<$Res> {
  factory _$MessageModelCopyWith(
          _MessageModel value, $Res Function(_MessageModel) then) =
      __$MessageModelCopyWithImpl<$Res>;

  @override
  $Res call(
      {String id,
      String creatorId,
      String text,
      @JsonKey(fromJson: ConvertUtils.dateTimeFromTimestampNonNull, toJson: ConvertUtils.dateTimeToTimestamp)
          DateTime createdAt,
      String chatId,
      @JsonKey(fromJson: ConvertUtils.dateTimeFromTimestamp, toJson: ConvertUtils.dateTimeToTimestamp)
          DateTime? updatedAt,
      bool isDeleted});
}

/// @nodoc
class __$MessageModelCopyWithImpl<$Res> extends _$MessageModelCopyWithImpl<$Res>
    implements _$MessageModelCopyWith<$Res> {
  __$MessageModelCopyWithImpl(
      _MessageModel _value, $Res Function(_MessageModel) _then)
      : super(_value, (v) => _then(v as _MessageModel));

  @override
  _MessageModel get _value => super._value as _MessageModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? creatorId = freezed,
    Object? text = freezed,
    Object? createdAt = freezed,
    Object? chatId = freezed,
    Object? updatedAt = freezed,
    Object? isDeleted = freezed,
  }) {
    return _then(_MessageModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      creatorId: creatorId == freezed
          ? _value.creatorId
          : creatorId // ignore: cast_nullable_to_non_nullable
              as String,
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      chatId: chatId == freezed
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isDeleted: isDeleted == freezed
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MessageModel extends _MessageModel {
  _$_MessageModel(
      {required this.id,
      required this.creatorId,
      required this.text,
      @JsonKey(fromJson: ConvertUtils.dateTimeFromTimestampNonNull, toJson: ConvertUtils.dateTimeToTimestamp)
          required this.createdAt,
      required this.chatId,
      @JsonKey(fromJson: ConvertUtils.dateTimeFromTimestamp, toJson: ConvertUtils.dateTimeToTimestamp)
          this.updatedAt,
      this.isDeleted = false})
      : super._();

  factory _$_MessageModel.fromJson(Map<String, dynamic> json) =>
      _$_$_MessageModelFromJson(json);

  @override
  final String id;
  @override
  final String creatorId;
  @override
  final String text;
  @override
  @JsonKey(
      fromJson: ConvertUtils.dateTimeFromTimestampNonNull,
      toJson: ConvertUtils.dateTimeToTimestamp)
  final DateTime createdAt;
  @override
  final String chatId;
  @override
  @JsonKey(
      fromJson: ConvertUtils.dateTimeFromTimestamp,
      toJson: ConvertUtils.dateTimeToTimestamp)
  final DateTime? updatedAt;
  @JsonKey(defaultValue: false)
  @override
  final bool isDeleted;

  @override
  String toString() {
    return 'MessageModel(id: $id, creatorId: $creatorId, text: $text, createdAt: $createdAt, chatId: $chatId, updatedAt: $updatedAt, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MessageModel &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.creatorId, creatorId) ||
                const DeepCollectionEquality()
                    .equals(other.creatorId, creatorId)) &&
            (identical(other.text, text) ||
                const DeepCollectionEquality().equals(other.text, text)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.chatId, chatId) ||
                const DeepCollectionEquality().equals(other.chatId, chatId)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)) &&
            (identical(other.isDeleted, isDeleted) ||
                const DeepCollectionEquality()
                    .equals(other.isDeleted, isDeleted)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(creatorId) ^
      const DeepCollectionEquality().hash(text) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(chatId) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(isDeleted);

  @JsonKey(ignore: true)
  @override
  _$MessageModelCopyWith<_MessageModel> get copyWith =>
      __$MessageModelCopyWithImpl<_MessageModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_MessageModelToJson(this);
  }
}

abstract class _MessageModel extends MessageModel {
  factory _MessageModel(
      {required String id,
      required String creatorId,
      required String text,
      @JsonKey(fromJson: ConvertUtils.dateTimeFromTimestampNonNull, toJson: ConvertUtils.dateTimeToTimestamp)
          required DateTime createdAt,
      required String chatId,
      @JsonKey(fromJson: ConvertUtils.dateTimeFromTimestamp, toJson: ConvertUtils.dateTimeToTimestamp)
          DateTime? updatedAt,
      bool isDeleted}) = _$_MessageModel;

  _MessageModel._() : super._();

  factory _MessageModel.fromJson(Map<String, dynamic> json) =
      _$_MessageModel.fromJson;

  @override
  String get id => throw _privateConstructorUsedError;

  @override
  String get creatorId => throw _privateConstructorUsedError;

  @override
  String get text => throw _privateConstructorUsedError;

  @override
  @JsonKey(
      fromJson: ConvertUtils.dateTimeFromTimestampNonNull,
      toJson: ConvertUtils.dateTimeToTimestamp)
  DateTime get createdAt => throw _privateConstructorUsedError;

  @override
  String get chatId => throw _privateConstructorUsedError;

  @override
  @JsonKey(
      fromJson: ConvertUtils.dateTimeFromTimestamp,
      toJson: ConvertUtils.dateTimeToTimestamp)
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  @override
  bool get isDeleted => throw _privateConstructorUsedError;

  @override
  @JsonKey(ignore: true)
  _$MessageModelCopyWith<_MessageModel> get copyWith =>
      throw _privateConstructorUsedError;
}
