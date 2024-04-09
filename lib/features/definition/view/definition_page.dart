import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lethologica_app/features/definition/cubit/definition_cubit.dart';

import 'package:lethologica_app/features/definition/definition.dart';
import 'package:lethologica_dictionary/lethologica_dictionary.dart';

class DefinitionPage extends StatelessWidget {
  const DefinitionPage({required this.word, super.key});

  final Word word;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DefinitionCubit(
        dictionaryRepository: context.read<DictionaryRepository>(),
        word: word,
      ),
      child: const DefinitionView(),
    );
  }
}
