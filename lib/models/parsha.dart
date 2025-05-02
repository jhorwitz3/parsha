// lib/models/parsha.dart

class Parsha {
  final String name;
  final String summary;
  final List<String> keyPoints;
  final List<String> themes;
  final List<Character> characters;
  final List<String> lessons;

  Parsha({
    required this.name,
    required this.summary,
    required this.keyPoints,
    required this.themes,
    required this.characters,
    required this.lessons,
  });

  factory Parsha.fromJson(Map<String, dynamic> json) {
    return Parsha(
      name: json['name'] ?? '',
      summary: json['summary'] ?? '',
      keyPoints: List<String>.from(json['keyPoints'] ?? []),
      themes: List<String>.from(json['themes'] ?? []),
      characters: List<Character>.from(
        (json['characters'] ?? [])
            .map((character) => Character.fromJson(character)),
      ),
      lessons: List<String>.from(json['lessons'] ?? []),
    );
  }
}

class Character {
  final String name;
  final String description;
  final List<String> keyActions;

  Character({
    required this.name,
    required this.description,
    required this.keyActions,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      keyActions: List<String>.from(json['keyActions'] ?? []),
    );
  }
}
