import 'package:flutter/material.dart';
import 'package:lethologica_theme/lethologica_theme.dart';

class LethologicaStyle {
  LethologicaStyle({
    required this.colorScheme,
  })  : light = ThemeData.from(
          useMaterial3: true,
          colorScheme: colorScheme.light,
          textTheme: LethologicaTextTheme.main,
        ),
        dark = ThemeData.from(
          useMaterial3: true,
          colorScheme: colorScheme.dark,
          textTheme: LethologicaTextTheme.main,
        );

  factory LethologicaStyle.fromSeedColor(Color seedColor) => LethologicaStyle(
        colorScheme: LethologicaColorScheme(seedColor: seedColor),
      );

  final LethologicaColorScheme colorScheme;

  late ThemeData light;
  late ThemeData dark;
}
