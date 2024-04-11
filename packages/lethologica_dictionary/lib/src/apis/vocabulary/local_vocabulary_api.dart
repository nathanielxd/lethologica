import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:lethologica_dictionary/lethologica_dictionary.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class LocalVocabularyApi implements VocabularyApi {
  LocalVocabularyApi();

  late File _file;
  final _controller = StreamController<List<Word>>.broadcast();
  var _currentWords = <Word>[];
  Word? _lastDeleted;

  @override
  Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    _file = File(join(dir.path, 'lethologica.json'));
    await _file.create();
  }

  @override
  Stream<List<Word>> get stream => _controller.stream;

  @override
  List<Word> get currentWords => _currentWords;

  @override
  Future<List<Word>> getAll() async {
    final dbContents = await _loadDatabase();
    _controller.add(
      _currentWords = dbContents
          .map((e) => Word.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
    return _currentWords;
  }

  @override
  Future<void> add(Word word) async {
    _currentWords.add(word);
    await _saveDatabase();
    _controller.add(_currentWords);
  }

  @override
  Future<void> delete(String word) async {
    _lastDeleted = _currentWords.firstWhere((element) => element.word == word);
    _currentWords.remove(_lastDeleted);
    await _saveDatabase();
    _controller.add(_currentWords);
  }

  @override
  Future<void> deleteAll() async {
    _currentWords.clear();
    await _saveDatabase();
    _controller.add(_currentWords);
  }

  @override
  Word? get lastDeleted => _lastDeleted;

  @override
  Future<void> sort(VocabularySortMode sortMode) async {
    switch (sortMode) {
      case VocabularySortMode.alphabetically:
        _currentWords.sort((a, b) => a.word.compareTo(b.word));
      case VocabularySortMode.timestamp:
        _currentWords.sort((a, b) => a.timeAdded!.compareTo(b.timeAdded!));
      case VocabularySortMode.length:
        _currentWords.sort((a, b) => a.word.length.compareTo(b.word.length));
    }
    await _saveDatabase();
    _controller.add(_currentWords);
  }

  Future<List<dynamic>> _loadDatabase() async {
    final fileContents = await _file.readAsString();
    if (fileContents.isEmpty) {
      return List.empty();
    }
    return jsonDecode(fileContents) as List<dynamic>;
  }

  Future<void> _saveDatabase() async {
    final data = _currentWords.map((e) => jsonEncode(e.toMap())).toList();
    await _file.writeAsString(data.toString());
  }
}
