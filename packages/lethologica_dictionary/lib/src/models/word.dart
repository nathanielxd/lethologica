import 'package:equatable/equatable.dart';
import 'package:lethologica_dictionary/lethologica_dictionary.dart';

class Word extends Equatable {
  const Word({
    required this.word,
    required this.phonetics,
    required this.meanings,
    this.origin,
    this.timeAdded,
  });

  factory Word.fromMap(Map<String, dynamic> map) {
    return Word(
      word: map['word'] as String,
      phonetics: (map['phonetics'] as List)
          .map((e) => Phonetic.fromMap(e as Map<String, dynamic>))
          .toList(),
      meanings: (map['meanings'] as List)
          .map(
            (e) => Meaning.fromMap(e as Map<String, dynamic>),
          )
          .toList(),
      origin: map['origin'] as String?,
      timeAdded: map['timeAdded'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['timeAdded'] as int)
          : null,
    );
  }

  static const empty = Word(word: '', phonetics: [], meanings: []);
  bool get isEmpty => this == empty;

  final String word;
  final List<Phonetic> phonetics;
  final List<Meaning> meanings;
  final String? origin;
  final DateTime? timeAdded;

  Word copyWith({
    String? word,
    List<Phonetic>? phonetics,
    List<Meaning>? meanings,
    String? origin,
    DateTime? timeAdded,
  }) {
    return Word(
      word: word ?? this.word,
      phonetics: phonetics ?? this.phonetics,
      meanings: meanings ?? this.meanings,
      origin: origin ?? this.origin,
      timeAdded: timeAdded ?? this.timeAdded,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'word': word,
      'phonetics': phonetics.map((e) => e.toMap()).toList(),
      'meanings': meanings.map((e) => e.toMap()).toList(),
      'origin': origin,
      'timeAdded': timeAdded?.millisecondsSinceEpoch,
    };
  }

  @override
  List<Object?> get props {
    return [
      word,
      phonetics,
      meanings,
      origin,
      timeAdded,
    ];
  }
}
