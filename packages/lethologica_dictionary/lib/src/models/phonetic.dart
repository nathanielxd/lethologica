import 'package:equatable/equatable.dart';

class Phonetic extends Equatable {
  const Phonetic({
    this.text,
    this.audio,
  });

  factory Phonetic.fromMap(Map<String, dynamic> map) {
    return Phonetic(
      text: map['text'] as String?,
      audio: map['audio'] as String?,
    );
  }

  final String? text;
  final String? audio;

  Phonetic copyWith({
    String? text,
    String? audio,
  }) {
    return Phonetic(
      text: text ?? this.text,
      audio: audio ?? this.audio,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'audio': audio,
    };
  }

  @override
  List<Object?> get props => [text, audio];
}
