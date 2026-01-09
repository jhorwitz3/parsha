import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:parsha/models/string_url_name_triplet.dart';

part 'parsha.freezed.dart';
part 'parsha.g.dart';

@freezed
class Parsha with _$Parsha {
  const factory Parsha({
    required String name,
    required StringUrlNameTriplet summary,
  }) = _Parsha;

  factory Parsha.fromJson(Map<String, dynamic> json) => _$ParshaFromJson(json);
}

@freezed
class Character with _$Character {
  const factory Character({
    required String name,
    required String description,
    required List<String> keyActions,
  }) = _Character;

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);
}
