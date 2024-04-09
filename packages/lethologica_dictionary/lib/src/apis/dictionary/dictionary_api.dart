import 'package:lethologica_dictionary/lethologica_dictionary.dart';

// ignore: one_member_abstracts
abstract class DictionaryApi {
  Future<Word> search(String query);
}
