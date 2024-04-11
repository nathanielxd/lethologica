import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lethologica_app/features/app/app.dart';
import 'package:lethologica_autosuggest/lethologica_autosuggest.dart';
import 'package:lethologica_dictionary/lethologica_dictionary.dart';
import 'package:lethologica_theme/lethologica_theme.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LethologicaStyleMaker(),
        ),
        RepositoryProvider(
          create: (context) => DictionaryRepository(
            dictionaryApi: RestfulDictionaryApi(),
            vocabularyApi: LocalVocabularyApi(),
          ),
        ),
        RepositoryProvider(
          create: (context) => AutosuggestRepository(
            assetPath: 'assets/words.txt',
          ),
        ),
      ],
      child: const AppView(),
    );
  }
}
