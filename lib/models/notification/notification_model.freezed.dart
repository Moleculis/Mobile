// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'notification_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) {
  return _NotificationModel.fromJson(json);
}

/// @nodoc
class _$NotificationModelTearOff {
  const _$NotificationModelTearOff();

  _NotificationModel call(
      {required String id,
      required String creatorUsername,
      required String receiverUsername,
      required String title,
      required String text,
      @JsonKey(toJson: EnumParser.toStringValue, fromJson: notificationTypeFromString)
          required NotificationType notificationType,
      @JsonKey(toJson: ConvertUtils.dateTimeToTimestamp, fromJson: ConvertUtils.dateTimeFromTimestampNonNull)
          required DateTime createdAt,
      bool isRead = false,
      String? valueName,
      String? valueId}) {
    return _NotificationModel(
      id: id,
      creatorUsername: creatorUsername,
      receiverUsername: receiverUsername,
      title: title,
      text: text,
      notificationType: notificationType,
      createdAt: createdAt,
      isRead: isRead,
      valueName: valueName,
      valueId: valueId,
    );
  }

  NotificationModel fromJson(Map<String, Object> json) {
    return NotificationModel.fromJson(json);
  }
}

/// @nodoc
const $NotificationModel = _$NotificationModelTearOff();

/// @nodoc
mixin _$NotificationModel {
  String get id => throw _privateConstructorUsedError;

  String get creatorUsername => throw _privateConstructorUsedError;

  String get receiverUsername => throw _privateConstructorUsedError;

  String get title => throw _privateConstructorUsedError;

  String get text => throw _privateConstructorUsedError;

  @JsonKey(
      toJson: EnumParser.toStringValue, fromJson: notificationTypeFromString)
  NotificationType get notificationType => throw _privateConstructorUsedError;

  @JsonKey(
      toJson: ConvertUtils.dateTimeToTimestamp,
      fromJson: ConvertUtils.dateTimeFromTimestampNonNull)
  DateTime get createdAt => throw _privateConstructorUsedError;

  bool get isRead => throw _privateConstructorUsedError;

  String? get valueName => throw _privateConstructorUsedError;

  String? get valueId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NotificationModelCopyWith<NotificationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationModelCopyWith<$Res> {
  factory $NotificationModelCopyWith(
          NotificationModel value, $Res Function(NotificationModel) then) =
      _$NotificationModelCopyWithImpl<$Res>;

  $Res call(
      {String id,
      String creatorUsername,
      String receiverUsername,
      String title,
      String text,
      @JsonKey(toJson: EnumParser.toStringValue, fromJson: notificationTypeFromString)
          NotificationType notificationType,
      @JsonKey(toJson: ConvertUtils.dateTimeToTimestamp, fromJson: ConvertUtils.dateTimeFromTimestampNonNull)
          DateTime createdAt,
      bool isRead,
      String? valueName,
      String? valueId});
}

/// @nodoc
class _$NotificationModelCopyWithImpl<$Res>
    implements $NotificationModelCopyWith<$Res> {
  _$NotificationModelCopyWithImpl(this._value, this._then);

  final NotificationModel _value;
  // ignore: unused_field
  final $Res Function(NotificationModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? creatorUsername = freezed,
    Object? receiverUsername = freezed,
    Object? title = freezed,
    Object? text = freezed,
    Object? notificationType = freezed,
    Object? createdAt = freezed,
    Object? isRead = freezed,
    Object? valueName = freezed,
    Object? valueId = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      creatorUsername: creatorUsername == freezed
          ? _value.creatorUsername
          : creatorUsername // ignore: cast_nullable_to_non_nullable
              as String,
      receiverUsername: receiverUsername == freezed
          ? _value.receiverUsername
          : receiverUsername // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      notificationType: notificationType == freezed
          ? _value.notificationType
          : notificationType // ignore: cast_nullable_to_non_nullable
              as NotificationType,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isRead: isRead == freezed
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      valueName: valueName == freezed
          ? _value.valueName
          : valueName // ignore: cast_nullable_to_non_nullable
              as String?,
      valueId: valueId == freezed
          ? _value.valueId
          : valueId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$NotificationModelCopyWith<$Res>
    implements $NotificationModelCopyWith<$Res> {
  factory _$NotificationModelCopyWith(
          _NotificationModel value, $Res Function(_NotificationModel) then) =
      __$NotificationModelCopyWithImpl<$Res>;

  @override
  $Res call(
      {String id,
      String creatorUsername,
      String receiverUsername,
      String title,
      String text,
      @JsonKey(toJson: EnumParser.toStringValue, fromJson: notificationTypeFromString)
          NotificationType notificationType,
      @JsonKey(toJson: ConvertUtils.dateTimeToTimestamp, fromJson: ConvertUtils.dateTimeFromTimestampNonNull)
          DateTime createdAt,
      bool isRead,
      String? valueName,
      String? valueId});
}

/// @nodoc
class __$NotificationModelCopyWithImpl<$Res>
    extends _$NotificationModelCopyWithImpl<$Res>
    implements _$NotificationModelCopyWith<$Res> {
  __$NotificationModelCopyWithImpl(
      _NotificationModel _value, $Res Function(_NotificationModel) _then)
      : super(_value, (v) => _then(v as _NotificationModel));

  @override
  _NotificationModel get _value => super._value as _NotificationModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? creatorUsername = freezed,
    Object? receiverUsername = freezed,
    Object? title = freezed,
    Object? text = freezed,
    Object? notificationType = freezed,
    Object? createdAt = freezed,
    Object? isRead = freezed,
    Object? valueName = freezed,
    Object? valueId = freezed,
  }) {
    return _then(_NotificationModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      creatorUsername: creatorUsername == freezed
          ? _value.creatorUsername
          : creatorUsername // ignore: cast_nullable_to_non_nullable
              as String,
      receiverUsername: receiverUsername == freezed
          ? _value.receiverUsername
          : receiverUsername // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      notificationType: notificationType == freezed
          ? _value.notificationType
          : notificationType // ignore: cast_nullable_to_non_nullable
              as NotificationType,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isRead: isRead == freezed
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      valueName: valueName == freezed
          ? _value.valueName
          : valueName // ignore: cast_nullable_to_non_nullable
              as String?,
      valueId: valueId == freezed
          ? _value.valueId
          : valueId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_NotificationModel implements _NotificationModel {
  _$_NotificationModel(
      {required this.id,
      required this.creatorUsername,
      required this.receiverUsername,
      required this.title,
      required this.text,
      @JsonKey(toJson: EnumParser.toStringValue, fromJson: notificationTypeFromString)
          required this.notificationType,
      @JsonKey(toJson: ConvertUtils.dateTimeToTimestamp, fromJson: ConvertUtils.dateTimeFromTimestampNonNull)
          required this.createdAt,
      this.isRead = false,
      this.valueName,
      this.valueId});

  factory _$_NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$_$_NotificationModelFromJson(json);

  @override
  final String id;
  @override
  final String creatorUsername;
  @override
  final String receiverUsername;
  @override
  final String title;
  @override
  final String text;
  @override
  @JsonKey(
      toJson: EnumParser.toStringValue, fromJson: notificationTypeFromString)
  final NotificationType notificationType;
  @override
  @JsonKey(
      toJson: ConvertUtils.dateTimeToTimestamp,
      fromJson: ConvertUtils.dateTimeFromTimestampNonNull)
  final DateTime createdAt;
  @JsonKey(defaultValue: false)
  @override
  final bool isRead;
  @override
  final String? valueName;
  @override
  final String? valueId;

  @override
  String toString() {
    return 'NotificationModel(id: $id, creatorUsername: $creatorUsername, receiverUsername: $receiverUsername, title: $title, text: $text, notificationType: $notificationType, createdAt: $createdAt, isRead: $isRead, valueName: $valueName, valueId: $valueId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _NotificationModel &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.creatorUsername, creatorUsername) ||
                const DeepCollectionEquality()
                    .equals(other.creatorUsername, creatorUsername)) &&
            (identical(other.receiverUsername, receiverUsername) ||
                const DeepCollectionEquality()
                    .equals(other.receiverUsername, receiverUsername)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.text, text) ||
                const DeepCollectionEquality().equals(other.text, text)) &&
            (identical(other.notificationType, notificationType) ||
                const DeepCollectionEquality()
                    .equals(other.notificationType, notificationType)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.isRead, isRead) ||
                const DeepCollectionEquality().equals(other.isRead, isRead)) &&
            (identical(other.valueName, valueName) ||
                const DeepCollectionEquality()
                    .equals(other.valueName, valueName)) &&
            (identical(other.valueId, valueId) ||
                const DeepCollectionEquality().equals(other.valueId, valueId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(creatorUsername) ^
      const DeepCollectionEquality().hash(receiverUsername) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(text) ^
      const DeepCollectionEquality().hash(notificationType) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(isRead) ^
      const DeepCollectionEquality().hash(valueName) ^
      const DeepCollectionEquality().hash(valueId);

  @JsonKey(ignore: true)
  @override
  _$NotificationModelCopyWith<_NotificationModel> get copyWith =>
      __$NotificationModelCopyWithImpl<_NotificationModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_NotificationModelToJson(this);
  }
}

abstract class _NotificationModel implements NotificationModel {
  factory _NotificationModel(
      {required String id,
      required String creatorUsername,
      required String receiverUsername,
      required String title,
      required String text,
      @JsonKey(toJson: EnumParser.toStringValue, fromJson: notificationTypeFromString)
          required NotificationType notificationType,
      @JsonKey(toJson: ConvertUtils.dateTimeToTimestamp, fromJson: ConvertUtils.dateTimeFromTimestampNonNull)
          required DateTime createdAt,
      bool isRead,
      String? valueName,
      String? valueId}) = _$_NotificationModel;

  factory _NotificationModel.fromJson(Map<String, dynamic> json) =
      _$_NotificationModel.fromJson;

  @override
  String get id => throw _privateConstructorUsedError;

  @override
  String get creatorUsername => throw _privateConstructorUsedError;

  @override
  String get receiverUsername => throw _privateConstructorUsedError;
  @override
  String get title => throw _privateConstructorUsedError;
  @override
  String get text => throw _privateConstructorUsedError;

  @override
  @JsonKey(
      toJson: EnumParser.toStringValue, fromJson: notificationTypeFromString)
  NotificationType get notificationType => throw _privateConstructorUsedError;

  @override
  @JsonKey(
      toJson: ConvertUtils.dateTimeToTimestamp,
      fromJson: ConvertUtils.dateTimeFromTimestampNonNull)
  DateTime get createdAt => throw _privateConstructorUsedError;

  @override
  bool get isRead => throw _privateConstructorUsedError;

  @override
  String? get valueName => throw _privateConstructorUsedError;

  @override
  String? get valueId => throw _privateConstructorUsedError;

  @override
  @JsonKey(ignore: true)
  _$NotificationModelCopyWith<_NotificationModel> get copyWith =>
      throw _privateConstructorUsedError;
}
