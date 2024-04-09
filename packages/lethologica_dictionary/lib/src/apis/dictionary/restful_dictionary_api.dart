import 'package:dio/dio.dart';
import 'package:lethologica_dictionary/lethologica_dictionary.dart';

class RestfulDictionaryApi implements DictionaryApi {
  final _dictionaryApi = Dio(
    BaseOptions(
      baseUrl: 'https://api.dictionaryapi.dev/api/v2/entries/en',
    ),
  );

  @override
  Future<Word> search(String query) async {
    final query0 = query.replaceAll(' ', '_');
    try {
      final response = await _dictionaryApi.get<List<dynamic>>('/$query0');
      return Word.fromMap(response.data![0] as Map<String, dynamic>);
    } on Exception {
      throw SearchException();
    }
  }
}
