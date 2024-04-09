import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lethologica_app/features/settings/settings.dart';
import 'package:lethologica_app/gen/fonts.gen.dart';
import 'package:lethologica_theme/lethologica_theme.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  Future<bool?> _showConfirmDialog(BuildContext context, String content) async {
    return showDialog<bool>(
      context: context,
      builder: (_) => SimpleDialog(
        title: const Text('Confirm'),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: Text(
              content,
            ),
          ),
          Row(
            children: [
              const Spacer(),
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'No',
                  style: TextStyle(
                    color: context.colorScheme.onBackground,
                  ),
                ),
              ),
              PaddingHorizontal(once),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
              PaddingHorizontal(twice),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Lethologica',
              style: context.textTheme.headlineMedium!
                  .copyWith(fontFamily: FontFamily.cookie),
            ),
            elevation: 1,
          ),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(once),
                  child: Text(
                    'GENERAL',
                    style: TextStyle(color: context.colorScheme.grey),
                  ),
                ),
                ListTile(
                  title: const Text('Clear your vocabulary'),
                  leading: const Icon(Icons.clear_all_rounded),
                  onTap: () async {
                    final response = await _showConfirmDialog(
                      context,
                      'Are you sure you want to '
                      'clear out your entire vocabulary?',
                    );
                    if (response != null && response) {
                      context.read<SettingsCubit>().clearAll();
                    }
                  },
                ),
                if (!state.lastDeleted.isEmpty)
                  ListTile(
                    title: const Text('Restore last deleted word'),
                    trailing: Chip(
                      label: Text(state.lastDeleted.word),
                    ),
                    leading: const Icon(Icons.restore),
                    onTap: () {
                      context.read<SettingsCubit>().restoreLastDeleted();
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
