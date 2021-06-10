// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'chat_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) {
  return _ChatModel.fromJson(json);
}

/// @nodoc
class _$ChatModelTearOff {
  const _$ChatModelTearOff();

  _ChatModel call(
      {required String id,
      @JsonKey(toJson: EnumParser.toStringValue, fromJson: chatTypeFromString)
          required ChatType chatType,
      required List<String> usersIds,
      String? groupId}) {
    return _ChatModel(
      id: id,
      chatType: chatType,
      usersIds: usersIds,
      groupId: groupId,
    );
  }

  ChatModel fromJson(Map<String, Object> json) {
    return ChatModel.fromJson(json);
  }
}

/// @nodoc
const $ChatModel = _$ChatModelTearOff();

/// @nodoc
mixin _$ChatModel {
  String get id => throw _privateConstructorUsedError;

  @JsonKey(toJson: EnumParser.toStringValue, fromJson: chatTypeFromString)
  ChatType get chatType => throw _privateConstructorUsedError;

  List<String> get usersIds => throw _privateConstructorUsedError;

  String? get groupId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChatModelCopyWith<ChatModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatModelCopyWith<$Res> {
  factory $ChatModelCopyWith(ChatModel value, $Res Function(ChatModel) then) =
      _$ChatModelCopyWithImpl<$Res>;

  $Res call(
      {String id,
      @JsonKey(toJson: EnumParser.toStringValue, fromJson: chatTypeFromString)
          ChatType chatType,
      List<String> usersIds,
      String? groupId});
}

/// @nodoc
class _$ChatModelCopyWithImpl<$Res> implements $ChatModelCopyWith<$Res> {
  _$ChatModelCopyWithImpl(this._value, this._then);

  final ChatModel _value;

  // ignore: unused_field
  final $Res Function(ChatModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? chatType = freezed,
    Object? usersIds = freezed,
    Object? groupId = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      chatType: chatType == freezed
          ? _value.chatType
          : chatType // ignore: cast_nullable_to_non_nullable
              as ChatType,
      usersIds: usersIds == freezed
          ? _value.usersIds
          : usersIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      groupId: groupId == freezed
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$ChatModelCopyWith<$Res> implements $ChatModelCopyWith<$Res> {
  factory _$ChatModelCopyWith(
          _ChatModel value, $Res Function(_ChatModel) then) =
      __$ChatModelCopyWithImpl<$Res>;

  @override
  $Res call(
      {String id,
      @JsonKey(toJson: EnumParser.toStringValue, fromJson: chatTypeFromString)
          ChatType chatType,
      List<String> usersIds,
      String? groupId});
}

/// @nodoc
class __$ChatModelCopyWithImpl<$Res> extends _$ChatModelCopyWithImpl<$Res>
    implements _$ChatModelCopyWith<$Res> {
  __$ChatModelCopyWithImpl(_ChatModel _value, $Res Function(_ChatModel) _then)
      : super(_value, (v) => _then(v as _ChatModel));

  @override
  _ChatModel get _value => super._value as _ChatModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? chatType = freezed,
    Object? usersIds = freezed,
    Object? groupId = freezed,
  }) {
    return _then(_ChatModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      chatType: chatType == freezed
          ? _value.chatType
          : chatType // ignore: cast_nullable_to_non_nullable
              as ChatType,
      usersIds: usersIds == freezed
          ? _value.usersIds
          : usersIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      groupId: groupId == freezed
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChatModel implements _ChatModel {
  _$_ChatModel(
      {required this.id,
      @JsonKey(toJson: EnumParser.toStringValue, fromJson: chatTypeFromString)
          required this.chatType,
      required this.usersIds,
      this.groupId});

  factory _$_ChatModel.fromJson(Map<String, dynamic> json) =>
      _$_$_ChatModelFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(toJson: EnumParser.toStringValue, fromJson: chatTypeFromString)
  final ChatType chatType;
  @override
  final List<String> usersIds;
  @override
  final String? groupId;

  @override
  String toString() {
    return 'ChatModel(id: $id, chatType: $chatType, usersIds: $usersIds, groupId: $groupId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ChatModel &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.chatType, chatType) ||
                const DeepCollectionEquality()
                    .equals(other.chatType, chatType)) &&
            (identical(other.usersIds, usersIds) ||
                const DeepCollectionEquality()
                    .equals(other.usersIds, usersIds)) &&
            (identical(other.groupId, groupId) ||
                const DeepCollectionEquality().equals(other.groupId, groupId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(chatType) ^
      const DeepCollectionEquality().hash(usersIds) ^
      const DeepCollectionEquality().hash(groupId);

  @JsonKey(ignore: true)
  @override
  _$ChatModelCopyWith<_ChatModel> get copyWith =>
      __$ChatModelCopyWithImpl<_ChatModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ChatModelToJson(this);
  }
}

abstract class _ChatModel implements ChatModel {
  factory _ChatModel(
      {required String id,
      @JsonKey(toJson: EnumParser.toStringValue, fromJson: chatTypeFromString)
          required ChatType chatType,
      required List<String> usersIds,
      String? groupId}) = _$_ChatModel;

  factory _ChatModel.fromJson(Map<String, dynamic> json) =
      _$_ChatModel.fromJson;

  @override
  String get id => throw _privateConstructorUsedError;

  @override
  @JsonKey(toJson: EnumParser.toStringValue, fromJson: chatTypeFromString)
  ChatType get chatType => throw _privateConstructorUsedError;

  @override
  List<String> get usersIds => throw _privateConstructorUsedError;

  @override
  String? get groupId => throw _privateConstructorUsedError;

  @override
  @JsonKey(ignore: true)
  _$ChatModelCopyWith<_ChatModel> get copyWith =>
      throw _privateConstructorUsedError;
}
