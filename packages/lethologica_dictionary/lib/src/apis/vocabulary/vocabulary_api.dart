import 'package:lethologica_dictionary/lethologica_dictionary.dart';

enum VocabularySortMode { alphabetically, timestamp, length }

abstract class VocabularyApi {
  Future<void> initialize();

  Stream<List<Word>> get stream;

  List<Word> get currentWords;

  Future<List<Word>> getAll();

  Future<void> add(Word word);

  Future<void> delete(String word);

  Future<void> deleteAll();

  Word? get lastDeleted;

  Future<void> sort(VocabularySortMode sortMode);
}
