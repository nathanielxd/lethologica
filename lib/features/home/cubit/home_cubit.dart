import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lethologica_dictionary/lethologica_dictionary.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required this.dictionaryRepository,
  }) : super(HomeState.pure()) {
    initialize();
  }

  final DictionaryRepository dictionaryRepository;

  Future<void> initialize() async {
    await dictionaryRepository.initialize();
    final vocabulary = await dictionaryRepository.getAll();
    emit(
      state.copyWith(
        fullVocabulary: vocabulary,
        visibleVocabulary: vocabulary,
      ),
    );
  }

  Future<void> search() async {
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

  Future<void> delete(Word word) async {
    await dictionaryRepository.delete(word.word);
  }

  void queryChanged(String value) {
    emit(
      state.copyWith(
        query: state.query.typing(value),
        visibleVocabulary: value.isNotEmpty
            ? state.fullVocabulary
                .where((element) => element.word.contains(value))
                .toList()
            : state.fullVocabulary,
      ),
    );
  }

  void queryCleared() => queryChanged('');
}
