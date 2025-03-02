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
  String get description => throw _privateConstructorUsedError;
  List<String> get characters => throw _privateConstructorUsedError;

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
  $Res call({String name, String description, List<String> characters});
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
    Object? description = null,
    Object? characters = null,
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
      characters: null == characters
          ? _value.characters
          : characters // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ParshaImplCopyWith<$Res> implements $ParshaCopyWith<$Res> {
  factory _$$ParshaImplCopyWith(
          _$ParshaImpl value, $Res Function(_$ParshaImpl) then) =
      __$$ParshaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String description, List<String> characters});
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
    Object? description = null,
    Object? characters = null,
  }) {
    return _then(_$ParshaImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      characters: null == characters
          ? _value._characters
          : characters // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ParshaImpl implements _Parsha {
  _$ParshaImpl(
      {required this.name,
      required this.description,
      required final List<String> characters})
      : _characters = characters;

  factory _$ParshaImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParshaImplFromJson(json);

  @override
  final String name;
  @override
  final String description;
  final List<String> _characters;
  @override
  List<String> get characters {
    if (_characters is EqualUnmodifiableListView) return _characters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_characters);
  }

  @override
  String toString() {
    return 'Parsha(name: $name, description: $description, characters: $characters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParshaImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._characters, _characters));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, description,
      const DeepCollectionEquality().hash(_characters));

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
  factory _Parsha(
      {required final String name,
      required final String description,
      required final List<String> characters}) = _$ParshaImpl;

  factory _Parsha.fromJson(Map<String, dynamic> json) = _$ParshaImpl.fromJson;

  @override
  String get name;
  @override
  String get description;
  @override
  List<String> get characters;

  /// Create a copy of Parsha
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ParshaImplCopyWith<_$ParshaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
