import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lethologica_app/features/home/home.dart';
import 'package:lethologica_autosuggest/lethologica_autosuggest.dart';
import 'package:lethologica_dictionary/lethologica_dictionary.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(
        dictionaryRepository: context.read<DictionaryRepository>(),
        autosuggestRepository: context.read<AutosuggestRepository>(),
      ),
      child: const HomeView(),
    );
  }
}
