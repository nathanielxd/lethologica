import 'package:equatable/equatable.dart';
import 'package:lethologica_dictionary/lethologica_dictionary.dart';

class Meaning extends Equatable {
  const Meaning({
    required this.partOfSpeech,
    required this.definitions,
  });

  factory Meaning.fromMap(Map<String, dynamic> map) {
    return Meaning(
      partOfSpeech: map['partOfSpeech'] as String,
      definitions: List<Definition>.from(
        (map['definitions'] as List).map<Definition>(
          (x) => Definition.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  final String partOfSpeech;
  final List<Definition> definitions;

  Meaning copyWith({
    String? partOfSpeech,
    List<Definition>? definitions,
  }) {
    return Meaning(
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      definitions: definitions ?? this.definitions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'partOfSpeech': partOfSpeech,
      'definitions': definitions.map((x) => x.toMap()).toList(),
    };
  }

  @override
  List<Object> get props => [partOfSpeech, definitions];
}
