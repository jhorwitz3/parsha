// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'string_url_pair.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StringUrlPair _$StringUrlPairFromJson(Map<String, dynamic> json) {
  return _StringUrlPair.fromJson(json);
}

/// @nodoc
mixin _$StringUrlPair {
  String get string => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;

  /// Serializes this StringUrlPair to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StringUrlPair
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StringUrlPairCopyWith<StringUrlPair> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StringUrlPairCopyWith<$Res> {
  factory $StringUrlPairCopyWith(
          StringUrlPair value, $Res Function(StringUrlPair) then) =
      _$StringUrlPairCopyWithImpl<$Res, StringUrlPair>;
  @useResult
  $Res call({String string, String url});
}

/// @nodoc
class _$StringUrlPairCopyWithImpl<$Res, $Val extends StringUrlPair>
    implements $StringUrlPairCopyWith<$Res> {
  _$StringUrlPairCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StringUrlPair
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? string = null,
    Object? url = null,
  }) {
    return _then(_value.copyWith(
      string: null == string
          ? _value.string
          : string // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StringUrlPairImplCopyWith<$Res>
    implements $StringUrlPairCopyWith<$Res> {
  factory _$$StringUrlPairImplCopyWith(
          _$StringUrlPairImpl value, $Res Function(_$StringUrlPairImpl) then) =
      __$$StringUrlPairImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String string, String url});
}

/// @nodoc
class __$$StringUrlPairImplCopyWithImpl<$Res>
    extends _$StringUrlPairCopyWithImpl<$Res, _$StringUrlPairImpl>
    implements _$$StringUrlPairImplCopyWith<$Res> {
  __$$StringUrlPairImplCopyWithImpl(
      _$StringUrlPairImpl _value, $Res Function(_$StringUrlPairImpl) _then)
      : super(_value, _then);

  /// Create a copy of StringUrlPair
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? string = null,
    Object? url = null,
  }) {
    return _then(_$StringUrlPairImpl(
      string: null == string
          ? _value.string
          : string // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StringUrlPairImpl implements _StringUrlPair {
  const _$StringUrlPairImpl({required this.string, required this.url});

  factory _$StringUrlPairImpl.fromJson(Map<String, dynamic> json) =>
      _$$StringUrlPairImplFromJson(json);

  @override
  final String string;
  @override
  final String url;

  @override
  String toString() {
    return 'StringUrlPair(string: $string, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StringUrlPairImpl &&
            (identical(other.string, string) || other.string == string) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, string, url);

  /// Create a copy of StringUrlPair
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StringUrlPairImplCopyWith<_$StringUrlPairImpl> get copyWith =>
      __$$StringUrlPairImplCopyWithImpl<_$StringUrlPairImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StringUrlPairImplToJson(
      this,
    );
  }
}

abstract class _StringUrlPair implements StringUrlPair {
  const factory _StringUrlPair(
      {required final String string,
      required final String url}) = _$StringUrlPairImpl;

  factory _StringUrlPair.fromJson(Map<String, dynamic> json) =
      _$StringUrlPairImpl.fromJson;

  @override
  String get string;
  @override
  String get url;

  /// Create a copy of StringUrlPair
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StringUrlPairImplCopyWith<_$StringUrlPairImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
