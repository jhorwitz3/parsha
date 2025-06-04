import 'package:freezed_annotation/freezed_annotation.dart';

part 'string_url_name_triplet.freezed.dart';
part 'string_url_name_triplet.g.dart';

@freezed
class StringUrlNameTriplet with _$StringUrlNameTriplet {
  const factory StringUrlNameTriplet({
    required String string,
    required String url,
    required String? name,
  }) = _StringUrlNameTriplet;

  factory StringUrlNameTriplet.fromJson(Map<String, dynamic> json) =>
      _$StringUrlNameTripletFromJson(json);
}
