import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:parsha/models/string_url_pair.dart';

part 'parsha.freezed.dart';
part 'parsha.g.dart';

@freezed
class Parsha with _$Parsha {
  const factory Parsha({
    required String name,
    required StringUrlPair summary,
    required List<StringUrlPair> keyPoints,
    required List<StringUrlPair> themes,
    required List<Character> characters,
    required List<StringUrlPair> lessons,
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
