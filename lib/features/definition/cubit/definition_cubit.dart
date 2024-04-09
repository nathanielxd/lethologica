import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lethologica_dictionary/lethologica_dictionary.dart';

part 'definition_state.dart';

class DefinitionCubit extends Cubit<DefinitionState> {
  DefinitionCubit({
    required this.dictionaryRepository,
    required this.word,
  }) : super(
          DefinitionState.pure(
            word: word,
            isSaved: dictionaryRepository.currentWords
                .any((element) => element.word == word.word),
          ),
        );

  final DictionaryRepository dictionaryRepository;
  final Word word;

  Future<void> save() async {
    emit(state.copyWith(status: DefinitionStatus.loading));
    await dictionaryRepository.add(word.copyWith(timeAdded: DateTime.now()));
    emit(state.copyWith(status: DefinitionStatus.saved));
  }
}
