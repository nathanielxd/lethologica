import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lethologica_dictionary/lethologica_dictionary.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({
    required this.dictionaryRepository,
  }) : super(
          SettingsState(
            lastDeleted: (!dictionaryRepository.currentWords.any(
                  (element) =>
                      element.word == dictionaryRepository.lastDeleted?.word,
                )
                    ? dictionaryRepository.lastDeleted
                    : Word.empty) ??
                Word.empty,
          ),
        );

  final DictionaryRepository dictionaryRepository;

  Future<void> clearAll() async {
    await dictionaryRepository.deleteAll();
  }

  Future<void> restoreLastDeleted() async {
    await dictionaryRepository.add(state.lastDeleted);
    emit(const SettingsState(lastDeleted: Word.empty));
  }

  Future<void> sortAlphabetically() async {
    await dictionaryRepository.sort(VocabularySortMode.alphabetically);
  }

  Future<void> soryByTimeAdded() async {
    await dictionaryRepository.sort(VocabularySortMode.timestamp);
  }

  Future<void> sortByWordLength() async {
    await dictionaryRepository.sort(VocabularySortMode.length);
  }
}
