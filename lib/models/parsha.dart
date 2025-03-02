import 'package:freezed_annotation/freezed_annotation.dart';
part 'parsha.freezed.dart';
part 'parsha.g.dart';

@freezed
abstract class Parsha with _$Parsha {
  factory Parsha({
    required String name,
    required String description,
    required List<String> characters,
  }) = _Parsha;

  factory Parsha.fromJson(Map<String, Object?> json) => _$ParshaFromJson(json);
}
