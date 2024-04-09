import 'package:flutter/material.dart';

class LethologicaTextTheme {
  static final main = _themeFromStyle(const TextStyle(fontFamily: 'Manrope'));

  static TextTheme _themeFromStyle(TextStyle style) {
    return Typography.englishLike2021.copyWith(
      displayLarge: style,
      displayMedium: style,
      displaySmall: style,
      headlineLarge: style,
      headlineMedium: style,
      headlineSmall: style,
      titleLarge: style,
      titleMedium: style,
      titleSmall: style,
      labelLarge: style,
      labelMedium: style,
      labelSmall: style,
      bodyLarge: style,
      bodyMedium: style,
      bodySmall: style,
    );
  }
}
