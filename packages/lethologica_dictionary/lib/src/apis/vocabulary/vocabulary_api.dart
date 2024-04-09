import 'package:lethologica_dictionary/lethologica_dictionary.dart';

abstract class VocabularyApi {
  Future<void> initialize();

  Stream<List<Word>> get stream;

  List<Word> get currentWords;

  Future<List<Word>> getAll();

  Future<void> add(Word word);

  Future<void> delete(String word);

  Future<void> deleteAll();

  Word? get lastDeleted;
}
