// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parsha.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Parsha _$ParshaFromJson(Map<String, dynamic> json) {
  return _Parsha.fromJson(json);
}

/// @nodoc
mixin _$Parsha {
  String get name => throw _privateConstructorUsedError;
  StringUrlNameTriplet get summary => throw _privateConstructorUsedError;

  /// Serializes this Parsha to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Parsha
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ParshaCopyWith<Parsha> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParshaCopyWith<$Res> {
  factory $ParshaCopyWith(Parsha value, $Res Function(Parsha) then) =
      _$ParshaCopyWithImpl<$Res, Parsha>;
  @useResult
  $Res call({String name, StringUrlNameTriplet summary});

  $StringUrlNameTripletCopyWith<$Res> get summary;
}

/// @nodoc
class _$ParshaCopyWithImpl<$Res, $Val extends Parsha>
    implements $ParshaCopyWith<$Res> {
  _$ParshaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Parsha
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? summary = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as StringUrlNameTriplet,
    ) as $Val);
  }

  /// Create a copy of Parsha
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StringUrlNameTripletCopyWith<$Res> get summary {
    return $StringUrlNameTripletCopyWith<$Res>(_value.summary, (value) {
      return _then(_value.copyWith(summary: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ParshaImplCopyWith<$Res> implements $ParshaCopyWith<$Res> {
  factory _$$ParshaImplCopyWith(
          _$ParshaImpl value, $Res Function(_$ParshaImpl) then) =
      __$$ParshaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, StringUrlNameTriplet summary});

  @override
  $StringUrlNameTripletCopyWith<$Res> get summary;
}

/// @nodoc
class __$$ParshaImplCopyWithImpl<$Res>
    extends _$ParshaCopyWithImpl<$Res, _$ParshaImpl>
    implements _$$ParshaImplCopyWith<$Res> {
  __$$ParshaImplCopyWithImpl(
      _$ParshaImpl _value, $Res Function(_$ParshaImpl) _then)
      : super(_value, _then);

  /// Create a copy of Parsha
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? summary = null,
  }) {
    return _then(_$ParshaImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as StringUrlNameTriplet,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ParshaImpl implements _Parsha {
  const _$ParshaImpl({required this.name, required this.summary});

  factory _$ParshaImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParshaImplFromJson(json);

  @override
  final String name;
  @override
  final StringUrlNameTriplet summary;

  @override
  String toString() {
    return 'Parsha(name: $name, summary: $summary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParshaImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.summary, summary) || other.summary == summary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, summary);

  /// Create a copy of Parsha
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ParshaImplCopyWith<_$ParshaImpl> get copyWith =>
      __$$ParshaImplCopyWithImpl<_$ParshaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ParshaImplToJson(
      this,
    );
  }
}

abstract class _Parsha implements Parsha {
  const factory _Parsha(
      {required final String name,
      required final StringUrlNameTriplet summary}) = _$ParshaImpl;

  factory _Parsha.fromJson(Map<String, dynamic> json) = _$ParshaImpl.fromJson;

  @override
  String get name;
  @override
  StringUrlNameTriplet get summary;

  /// Create a copy of Parsha
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ParshaImplCopyWith<_$ParshaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Character _$CharacterFromJson(Map<String, dynamic> json) {
  return _Character.fromJson(json);
}

/// @nodoc
mixin _$Character {
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String> get keyActions => throw _privateConstructorUsedError;

  /// Serializes this Character to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Character
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CharacterCopyWith<Character> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CharacterCopyWith<$Res> {
  factory $CharacterCopyWith(Character value, $Res Function(Character) then) =
      _$CharacterCopyWithImpl<$Res, Character>;
  @useResult
  $Res call({String name, String description, List<String> keyActions});
}

/// @nodoc
class _$CharacterCopyWithImpl<$Res, $Val extends Character>
    implements $CharacterCopyWith<$Res> {
  _$CharacterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Character
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? keyActions = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      keyActions: null == keyActions
          ? _value.keyActions
          : keyActions // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CharacterImplCopyWith<$Res>
    implements $CharacterCopyWith<$Res> {
  factory _$$CharacterImplCopyWith(
          _$CharacterImpl value, $Res Function(_$CharacterImpl) then) =
      __$$CharacterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String description, List<String> keyActions});
}

/// @nodoc
class __$$CharacterImplCopyWithImpl<$Res>
    extends _$CharacterCopyWithImpl<$Res, _$CharacterImpl>
    implements _$$CharacterImplCopyWith<$Res> {
  __$$CharacterImplCopyWithImpl(
      _$CharacterImpl _value, $Res Function(_$CharacterImpl) _then)
      : super(_value, _then);

  /// Create a copy of Character
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? keyActions = null,
  }) {
    return _then(_$CharacterImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      keyActions: null == keyActions
          ? _value._keyActions
          : keyActions // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CharacterImpl implements _Character {
  const _$CharacterImpl(
      {required this.name,
      required this.description,
      required final List<String> keyActions})
      : _keyActions = keyActions;

  factory _$CharacterImpl.fromJson(Map<String, dynamic> json) =>
      _$$CharacterImplFromJson(json);

  @override
  final String name;
  @override
  final String description;
  final List<String> _keyActions;
  @override
  List<String> get keyActions {
    if (_keyActions is EqualUnmodifiableListView) return _keyActions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_keyActions);
  }

  @override
  String toString() {
    return 'Character(name: $name, description: $description, keyActions: $keyActions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CharacterImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._keyActions, _keyActions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, description,
      const DeepCollectionEquality().hash(_keyActions));

  /// Create a copy of Character
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CharacterImplCopyWith<_$CharacterImpl> get copyWith =>
      __$$CharacterImplCopyWithImpl<_$CharacterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CharacterImplToJson(
      this,
    );
  }
}

abstract class _Character implements Character {
  const factory _Character(
      {required final String name,
      required final String description,
      required final List<String> keyActions}) = _$CharacterImpl;

  factory _Character.fromJson(Map<String, dynamic> json) =
      _$CharacterImpl.fromJson;

  @override
  String get name;
  @override
  String get description;
  @override
  List<String> get keyActions;

  /// Create a copy of Character
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CharacterImplCopyWith<_$CharacterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
