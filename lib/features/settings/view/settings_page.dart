import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lethologica_app/features/settings/settings.dart';
import 'package:lethologica_dictionary/lethologica_dictionary.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(
        dictionaryRepository: context.read<DictionaryRepository>(),
      ),
      child: const SettingsView(),
    );
  }
}
