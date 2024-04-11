import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lethologica_autosuggest/lethologica_autosuggest.dart';
import 'package:lethologica_dictionary/lethologica_dictionary.dart';
import 'package:lethologica_theme/lethologica_theme.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required this.dictionaryRepository,
    required this.autosuggestRepository,
    required this.styleMaker,
  }) : super(HomeState.pure()) {
    initialize();
  }

  final DictionaryRepository dictionaryRepository;
  final AutosuggestRepository autosuggestRepository;
  final LethologicaStyleMaker styleMaker;

  late StreamSubscription<List<Word>> _subscription;

  Future<void> initialize() async {
    await dictionaryRepository.initialize();
    await autosuggestRepository.initialize();
    await styleMaker.initialize();

    final vocabulary = await dictionaryRepository.getAll();
    emit(
      state.copyWith(
        fullVocabulary: vocabulary,
        visibleVocabulary: vocabulary,
      ),
    );

    _subscription = dictionaryRepository.stream
        .listen((event) => emit(state.copyWith(fullVocabulary: event)));
  }

  Future<void> querySearch() async {
    if (state.query.search.isEmpty) return;
    try {
      emit(state.copyWith(query: state.query.loading()));
      final result = await dictionaryRepository.search(state.query.search);
      emit(state.copyWith(query: state.query.queried(result)));
    } on SearchException {
      emit(state.copyWith(query: state.query.error()));
    } finally {
      emit(state.copyWith(query: state.query.idle()));
    }
  }

  Future<void> querySuggestion(String suggestion) async {
    try {
      emit(state.copyWith(query: state.query.loading()));
      final result = await dictionaryRepository.search(suggestion);
      emit(state.copyWith(query: state.query.queried(result)));
    } on SearchException {
      emit(state.copyWith(query: state.query.error()));
    } finally {
      emit(state.copyWith(query: state.query.idle()));
    }
  }

  Future<void> delete(Word word) async {
    await dictionaryRepository.delete(word.word);
  }

  void searchChanged(String value) {
    emit(
      state.copyWith(
        query: state.query.typing(value),
        visibleVocabulary: value.isNotEmpty
            ? state.fullVocabulary
                .where((element) => element.word.contains(value))
                .toList()
            : state.fullVocabulary,
        visibleSuggestions:
            value.isNotEmpty ? autosuggestRepository.suggest(value) : [],
      ),
    );
  }

  void searchCleared() => searchChanged('');

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
