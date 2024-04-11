part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    required this.fullVocabulary,
    required this.visibleVocabulary,
    required this.visibleSuggestions,
    required this.query,
  });

  factory HomeState.pure() => HomeState(
        fullVocabulary: const [],
        visibleVocabulary: const [],
        visibleSuggestions: const [],
        query: HomeQuery.pure(),
      );

  final List<Word> fullVocabulary;
  final List<Word> visibleVocabulary;
  final List<String> visibleSuggestions;
  final HomeQuery query;

  HomeState copyWith({
    List<Word>? fullVocabulary,
    List<Word>? visibleVocabulary,
    List<String>? visibleSuggestions,
    HomeQuery? query,
  }) {
    return HomeState(
      fullVocabulary: fullVocabulary ?? this.fullVocabulary,
      visibleVocabulary: visibleVocabulary ?? this.visibleVocabulary,
      visibleSuggestions: visibleSuggestions ?? this.visibleSuggestions,
      query: query ?? this.query,
    );
  }

  @override
  List<Object?> get props =>
      [fullVocabulary, visibleVocabulary, visibleSuggestions, query];
}

enum HomeQueryStatus { idle, loading, queried, error }

class HomeQuery extends Equatable {
  const HomeQuery({
    required this.status,
    required this.search,
    required this.word,
  });

  factory HomeQuery.pure() => const HomeQuery(
        status: HomeQueryStatus.idle,
        search: '',
        word: Word.empty,
      );

  HomeQuery idle() => copyWith(status: HomeQueryStatus.idle, word: Word.empty);

  HomeQuery typing(String query) =>
      copyWith(status: HomeQueryStatus.idle, search: query, word: Word.empty);

  HomeQuery loading() =>
      copyWith(status: HomeQueryStatus.loading, word: Word.empty);

  HomeQuery queried(Word word) =>
      copyWith(status: HomeQueryStatus.queried, word: word);

  HomeQuery error() =>
      copyWith(status: HomeQueryStatus.error, word: Word.empty);

  final HomeQueryStatus status;
  final String search;
  final Word word;

  HomeQuery copyWith({
    HomeQueryStatus? status,
    String? search,
    Word? word,
  }) {
    return HomeQuery(
      status: status ?? this.status,
      search: search ?? this.search,
      word: word ?? this.word,
    );
  }

  bool get isEmpty => search.isEmpty;
  bool get isTyping => search.isNotEmpty;
  bool get isLoading => status == HomeQueryStatus.loading;
  bool get isQueried => status == HomeQueryStatus.queried;

  @override
  List<Object> get props => [status, search, word];
}
