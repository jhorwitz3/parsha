// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'string_url_name_triplet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StringUrlNameTriplet _$StringUrlNameTripletFromJson(Map<String, dynamic> json) {
  return _StringUrlNameTriplet.fromJson(json);
}

/// @nodoc
mixin _$StringUrlNameTriplet {
  String get string => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  /// Serializes this StringUrlNameTriplet to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StringUrlNameTriplet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StringUrlNameTripletCopyWith<StringUrlNameTriplet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StringUrlNameTripletCopyWith<$Res> {
  factory $StringUrlNameTripletCopyWith(StringUrlNameTriplet value,
          $Res Function(StringUrlNameTriplet) then) =
      _$StringUrlNameTripletCopyWithImpl<$Res, StringUrlNameTriplet>;
  @useResult
  $Res call({String string, String url, String? name});
}

/// @nodoc
class _$StringUrlNameTripletCopyWithImpl<$Res,
        $Val extends StringUrlNameTriplet>
    implements $StringUrlNameTripletCopyWith<$Res> {
  _$StringUrlNameTripletCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StringUrlNameTriplet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? string = null,
    Object? url = null,
    Object? name = freezed,
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
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StringUrlNameTripletImplCopyWith<$Res>
    implements $StringUrlNameTripletCopyWith<$Res> {
  factory _$$StringUrlNameTripletImplCopyWith(_$StringUrlNameTripletImpl value,
          $Res Function(_$StringUrlNameTripletImpl) then) =
      __$$StringUrlNameTripletImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String string, String url, String? name});
}

/// @nodoc
class __$$StringUrlNameTripletImplCopyWithImpl<$Res>
    extends _$StringUrlNameTripletCopyWithImpl<$Res, _$StringUrlNameTripletImpl>
    implements _$$StringUrlNameTripletImplCopyWith<$Res> {
  __$$StringUrlNameTripletImplCopyWithImpl(_$StringUrlNameTripletImpl _value,
      $Res Function(_$StringUrlNameTripletImpl) _then)
      : super(_value, _then);

  /// Create a copy of StringUrlNameTriplet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? string = null,
    Object? url = null,
    Object? name = freezed,
  }) {
    return _then(_$StringUrlNameTripletImpl(
      string: null == string
          ? _value.string
          : string // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StringUrlNameTripletImpl implements _StringUrlNameTriplet {
  const _$StringUrlNameTripletImpl(
      {required this.string, required this.url, required this.name});

  factory _$StringUrlNameTripletImpl.fromJson(Map<String, dynamic> json) =>
      _$$StringUrlNameTripletImplFromJson(json);

  @override
  final String string;
  @override
  final String url;
  @override
  final String? name;

  @override
  String toString() {
    return 'StringUrlNameTriplet(string: $string, url: $url, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StringUrlNameTripletImpl &&
            (identical(other.string, string) || other.string == string) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, string, url, name);

  /// Create a copy of StringUrlNameTriplet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StringUrlNameTripletImplCopyWith<_$StringUrlNameTripletImpl>
      get copyWith =>
          __$$StringUrlNameTripletImplCopyWithImpl<_$StringUrlNameTripletImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StringUrlNameTripletImplToJson(
      this,
    );
  }
}

abstract class _StringUrlNameTriplet implements StringUrlNameTriplet {
  const factory _StringUrlNameTriplet(
      {required final String string,
      required final String url,
      required final String? name}) = _$StringUrlNameTripletImpl;

  factory _StringUrlNameTriplet.fromJson(Map<String, dynamic> json) =
      _$StringUrlNameTripletImpl.fromJson;

  @override
  String get string;
  @override
  String get url;
  @override
  String? get name;

  /// Create a copy of StringUrlNameTriplet
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StringUrlNameTripletImplCopyWith<_$StringUrlNameTripletImpl>
      get copyWith => throw _privateConstructorUsedError;
}
