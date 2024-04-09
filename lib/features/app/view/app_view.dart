import 'package:flutter/material.dart';
import 'package:lethologica_app/router.dart';
import 'package:lethologica_theme/lethologica_theme.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: LethologicaStyle.light,
      darkTheme: LethologicaStyle.dark,
      routerConfig: router,
    );
  }
}
