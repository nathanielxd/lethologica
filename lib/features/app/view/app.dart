import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lethologica_app/features/app/app.dart';
import 'package:lethologica_dictionary/lethologica_dictionary.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => DictionaryRepository(
        dictionaryApi: RestfulDictionaryApi(),
        vocabularyApi: LocalVocabularyApi(),
      ),
      child: const AppView(),
    );
  }
}
