import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lethologica_dictionary/lethologica_dictionary.dart';
import 'package:lethologica_theme/lethologica_theme.dart';

class WordWidget extends StatelessWidget {
  const WordWidget({required this.word, required this.onDismissed, super.key});

  final Word word;
  final void Function() onDismissed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/definition', extra: word),
      child: Dismissible(
        key: Key(word.word),
        direction: DismissDirection.endToStart,
        onDismissed: (_) => onDismissed(),
        background: Container(
          alignment: Alignment.centerRight,
          color: context.colorScheme.errorContainer,
          child: Padding(
            padding: EdgeInsets.only(right: twice),
            child: Icon(
              Icons.delete_outline,
              size: 30,
              color: context.colorScheme.onErrorContainer,
            ),
          ),
        ),
        child: ListTile(
          title: Text(word.word),
          subtitle: Text(
            word.meanings.first.definitions.first.definition,
            maxLines: 2,
          ),
        ),
      ),
    );
  }
}
