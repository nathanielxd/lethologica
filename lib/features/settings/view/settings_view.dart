import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lethologica_app/features/settings/settings.dart';
import 'package:lethologica_app/gen/assets.gen.dart';
import 'package:lethologica_app/gen/fonts.gen.dart';
import 'package:lethologica_theme/lethologica_theme.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
            child: ListView(
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
                MenuAnchor(
                  alignmentOffset: Offset(once, 0),
                  builder: (context, controller, child) {
                    return ListTile(
                      onTap: () {
                        if (controller.isOpen) {
                          controller.close();
                        } else {
                          controller.open();
                        }
                      },
                      leading: const Icon(Icons.sort),
                      trailing: const Icon(Icons.keyboard_arrow_down),
                      title: const Text('Sort all words'),
                    );
                  },
                  menuChildren: [
                    MenuItemButton(
                      onPressed: () {
                        context.read<SettingsCubit>().sortAlphabetically();
                      },
                      leadingIcon: const Icon(Icons.sort_by_alpha_rounded),
                      child: const Text('Sort alphabetically'),
                    ),
                    MenuItemButton(
                      onPressed: () {
                        context.read<SettingsCubit>().soryByTimeAdded();
                      },
                      leadingIcon: const Icon(Icons.timelapse_rounded),
                      child: const Text('Sort by time added'),
                    ),
                    MenuItemButton(
                      onPressed: () {
                        context.read<SettingsCubit>().sortByWordLength();
                      },
                      leadingIcon: const Icon(Icons.sort),
                      child: const Text('Sort by word length'),
                    ),
                  ],
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
                const ListTile(
                  leading: Icon(Icons.theater_comedy_rounded),
                  title: Text('Change app theme'),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, once, 16, once),
                  child: Row(
                    // alignment: WrapAlignment.center,
                    // spacing: twice,
                    // runSpacing: twice,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Color.fromARGB(255, 148, 151, 154),
                      Colors.red,
                      Colors.purple,
                      Colors.blue,
                      Colors.teal,
                      Colors.green,
                      Colors.yellow,
                      Colors.orange,
                      Colors.brown,
                    ]
                        .map(
                          (e) => InkWell(
                            onTap: () => context
                                .read<LethologicaStyleMaker>()
                                .changeStyle(e),
                            customBorder: const CircleBorder(),
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: e.withOpacity(0.6),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 1.5,
                                  color: context.colorScheme.onBackground,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(once),
                  child: Text(
                    'SUPPORT',
                    style: TextStyle(color: context.colorScheme.grey),
                  ),
                ),
                ListTile(
                  title: const Text('Like my app?'),
                  subtitle: const Text(
                    'Support handcrafted easy-to-use '
                    'apps by tipping me a coffee.',
                  ),
                  leading: const Icon(Icons.coffee),
                  onTap: () => launchUrlString(
                    'https://ko-fi.com/nathanielxd',
                    mode: LaunchMode.externalApplication,
                  ),
                ),
                ListTile(
                  title: const Text("Curious of what's behind?"),
                  subtitle: const Text(
                    'This app is open-source on GitHub.',
                  ),
                  leading: const Icon(Icons.flutter_dash_rounded),
                  onTap: () => launchUrlString(
                    'https://github.com/nathanielxd/lethologica',
                    mode: LaunchMode.externalApplication,
                  ),
                ),
                ListTile(
                  title: const Text('Like my stuff?'),
                  subtitle: const Text(
                    'Have a look at my entire portfolio and hire me.',
                  ),
                  leading: Assets.happy.image(
                    height: 24,
                    color: context.colorScheme.onBackground.withOpacity(0.9),
                  ),
                  onTap: () => launchUrlString(
                    'https://nathandevelops.com',
                    mode: LaunchMode.externalApplication,
                  ),
                ),
                ListTile(
                  title: const Text('Having trouble with the app?'),
                  subtitle: const Text(
                    'Check out the help page.',
                  ),
                  leading: const Icon(Icons.help_rounded),
                  onTap: () => context.pushReplacement('/help'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
