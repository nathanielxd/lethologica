part of 'definition_cubit.dart';

enum DefinitionStatus { idle, loading, saved, deleted }

class DefinitionState extends Equatable {
  const DefinitionState({
    required this.status,
    required this.word,
    required this.isSaved,
  });

  factory DefinitionState.pure({
    required Word word,
    required bool isSaved,
  }) =>
      DefinitionState(
        status: DefinitionStatus.idle,
        word: word,
        isSaved: isSaved,
      );

  final DefinitionStatus status;
  final Word word;
  final bool isSaved;

  DefinitionState copyWith({
    DefinitionStatus? status,
    Word? word,
    bool? isSaved,
  }) {
    return DefinitionState(
      status: status ?? this.status,
      word: word ?? this.word,
      isSaved: isSaved ?? this.isSaved,
    );
  }

  @override
  List<Object> get props => [status, word, isSaved];
}
