import 'package:go_router/go_router.dart';
import 'package:lethologica_app/features/definition/definition.dart';
import 'package:lethologica_app/features/home/home.dart';
import 'package:lethologica_app/features/settings/settings.dart';
import 'package:lethologica_dictionary/lethologica_dictionary.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/definition',
      builder: (context, state) => DefinitionPage(word: state.extra! as Word),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
    ),
  ],
);
