import 'package:freezed_annotation/freezed_annotation.dart';

part 'string_url_pair.freezed.dart';
part 'string_url_pair.g.dart';

@freezed
class StringUrlPair with _$StringUrlPair {
  const factory StringUrlPair({
    required String string,
    required String url,
  }) = _StringUrlPair;

  factory StringUrlPair.fromJson(Map<String, dynamic> json) =>
      _$StringUrlPairFromJson(json);
}
