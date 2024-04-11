import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lethologica_app/router.dart';
import 'package:lethologica_theme/lethologica_theme.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: context.read<LethologicaStyleMaker>(),
      builder: (context, _) {
        final currentStyle = context.read<LethologicaStyleMaker>().currentStyle;
        return MaterialApp.router(
          theme: currentStyle.light,
          darkTheme: currentStyle.dark,
          routerConfig: router,
        );
      },
    );
  }
}
