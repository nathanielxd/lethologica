import 'package:equatable/equatable.dart';

class Definition extends Equatable {
  const Definition({
    required this.definition,
    required this.example,
    required this.synonyms,
    required this.antonyms,
  });

  factory Definition.fromMap(Map<String, dynamic> map) {
    return Definition(
      definition: map['definition'] as String,
      example: map['example'] as String? ?? '',
      synonyms: (map['synonyms'] as List).map((e) => e as String).toList(),
      antonyms: (map['antonyms'] as List).map((e) => e as String).toList(),
    );
  }

  final String definition;
  final String example;
  final List<String> synonyms;
  final List<String> antonyms;

  Definition copyWith({
    String? definition,
    String? example,
    List<String>? synonyms,
    List<String>? antonyms,
  }) {
    return Definition(
      definition: definition ?? this.definition,
      example: example ?? this.example,
      synonyms: synonyms ?? this.synonyms,
      antonyms: antonyms ?? this.antonyms,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'definition': definition,
      'example': example,
      'synonyms': synonyms,
      'antonyms': antonyms,
    };
  }

  @override
  List<Object> get props => [definition, example, synonyms, antonyms];
}
