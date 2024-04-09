import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lethologica_app/features/definition/definition.dart';
import 'package:lethologica_app/gen/fonts.gen.dart';
import 'package:lethologica_dictionary/lethologica_dictionary.dart';
import 'package:lethologica_theme/lethologica_theme.dart';

class DefinitionView extends StatelessWidget {
  const DefinitionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DefinitionCubit, DefinitionState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 1,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.word.word,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                if (state.word.phonetics.isNotEmpty)
                  Text(
                    state.word.phonetics
                        .where((element) => element.text != null)
                        .map((e) => e.text)
                        .join(', '),
                    style: context.textTheme.bodyMedium!
                        .copyWith(fontFamily: 'Roboto'),
                  ),
              ],
            ),
          ),
          floatingActionButton: !state.isSaved
              ? FloatingActionButton.extended(
                  onPressed: () {
                    context.read<DefinitionCubit>().save();
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add to vocabulary'),
                )
              : null,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(once),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...state.word.meanings.map(
                      (e) => Padding(
                        padding: EdgeInsets.only(bottom: twice),
                        child: _Meaning(meaning: e),
                      ),
                    ),
                    if (state.word.origin != null) Text(state.word.origin!),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Meaning extends StatelessWidget {
  const _Meaning({
    required this.meaning,
  });

  final Meaning meaning;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: context.textTheme.bodyLarge!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            meaning.partOfSpeech,
            style: TextStyle(
              color: context.colorScheme.onBackground.withOpacity(0.6),
              fontStyle: FontStyle.italic,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: meaning.definitions
                .take(9)
                .toList()
                .asMap()
                .entries
                .map(
                  (e) => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PaddingHorizontal(once),
                      Text(
                        '${e.key + 1}.',
                        style: const TextStyle(
                          fontFamily: FontFamily.redditMono,
                        ),
                      ),
                      PaddingHorizontal(once),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(e.value.definition),
                            if (e.value.example.isNotEmpty)
                              Text(
                                '"${e.value.example}"',
                                style: TextStyle(
                                  color: context.colorScheme.onBackground
                                      .withOpacity(0.6),
                                ),
                              ),
                            if (e.value.synonyms.isNotEmpty)
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Synonyms: ',
                                      style: TextStyle(
                                        color: context.colorScheme.primary,
                                      ),
                                    ),
                                    TextSpan(
                                      text: e.value.synonyms.join(', '),
                                    ),
                                  ],
                                ),
                              ),
                            if (e.value.antonyms.isNotEmpty)
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Antonyms: ',
                                      style: TextStyle(
                                        color: context.colorScheme.tertiary,
                                      ),
                                    ),
                                    TextSpan(
                                      text: e.value.antonyms.join(', '),
                                    ),
                                  ],
                                ),
                              ),
                            PaddingVertical(twice),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
