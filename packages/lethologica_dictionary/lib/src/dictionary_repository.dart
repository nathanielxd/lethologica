import 'package:lethologica_dictionary/lethologica_dictionary.dart';

class DictionaryRepository {
  DictionaryRepository({
    required this.dictionaryApi,
    required this.vocabularyApi,
  });

  final DictionaryApi dictionaryApi;
  final VocabularyApi vocabularyApi;

  Future<void> initialize() => vocabularyApi.initialize();

  Future<Word> search(String query) => dictionaryApi.search(query);

  Stream<List<Word>> get stream => vocabularyApi.stream;

  List<Word> get currentWords => vocabularyApi.currentWords;

  Future<List<Word>> getAll() => vocabularyApi.getAll();

  Future<void> add(Word word) => vocabularyApi.add(word);

  Future<void> delete(String word) => vocabularyApi.delete(word);

  Future<void> deleteAll() => vocabularyApi.deleteAll();

  Word? get lastDeleted => vocabularyApi.lastDeleted;
}
