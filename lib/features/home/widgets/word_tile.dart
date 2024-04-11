import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:lethologica_dictionary/lethologica_dictionary.dart';
import 'package:lethologica_theme/lethologica_theme.dart';

class WordTile extends StatelessWidget {
  const WordTile({required this.word, required this.onDismissed, super.key});

  final Word word;
  final void Function() onDismissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
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
        onTap: () => context.push('/definition', extra: word),
        onLongPress: () {
          Clipboard.setData(ClipboardData(text: word.word));
        },
        title: Text(word.word),
        subtitle: Text(
          word.meanings.first.definitions.first.definition,
          maxLines: 2,
        ),
      ),
    );
  }
}
