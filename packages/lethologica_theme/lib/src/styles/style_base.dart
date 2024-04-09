import 'package:flutter/material.dart';
import 'package:lethologica_theme/lethologica_theme.dart';

class LethologicaStyle {
  static final light = ThemeData.from(
    useMaterial3: true,
    colorScheme: LethologicaColorScheme.light,
    textTheme: LethologicaTextTheme.main,
  );

  static final dark = ThemeData.from(
    useMaterial3: true,
    colorScheme: LethologicaColorScheme.dark,
    textTheme: LethologicaTextTheme.main,
  );
}
