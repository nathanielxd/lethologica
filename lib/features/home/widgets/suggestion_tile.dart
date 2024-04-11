import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lethologica_app/features/home/home.dart';
import 'package:lethologica_theme/lethologica_theme.dart';

class SuggestionTile extends StatelessWidget {
  const SuggestionTile({
    required this.suggestion,
    super.key,
  });

  final String suggestion;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title:
          Text(suggestion, style: TextStyle(color: context.colorScheme.grey)),
      onTap: () => context.read<HomeCubit>().querySuggestion(suggestion),
      onLongPress: () => Clipboard.setData(ClipboardData(text: suggestion)),
    );
  }
}
