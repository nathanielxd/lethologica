import 'package:flutter/services.dart' show rootBundle;

class AutosuggestRepository {
  AutosuggestRepository({required this.assetPath});

  final String assetPath;
  late final Map<String, Set<String>> _processed;

  Future<void> initialize() async {
    final words = (await rootBundle.loadString(assetPath)).split('\n');
    final processed = <String, Set<String>>{};

    for (var i = 0; i < words.length; i++) {
      final take3 = String.fromCharCodes(words[i].runes.take(3));
      if (processed[take3] == null) {
        processed[take3] = <String>{};
      }
      processed[take3]!.add(words[i]);

      final take4 = String.fromCharCodes(words[i].runes.take(4));
      if (processed[take4] == null) {
        processed[take4] = <String>{};
      }
      processed[take4]!.add(words[i]);

      final take5 = String.fromCharCodes(words[i].runes.take(5));
      if (processed[take5] == null) {
        processed[take5] = <String>{};
      }
      processed[take5]!.add(words[i]);
    }

    _processed = Map.from(processed);
  }

  List<String> suggest(String query) {
    final query0 = String.fromCharCodes(query.runes.take(5));
    return _processed[query0]?.toList() ?? [];
  }
}
