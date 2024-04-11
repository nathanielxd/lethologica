import 'package:flutter/material.dart';

class LethologicaColorScheme {
  LethologicaColorScheme({
    this.seedColor = const Color(0xffb3f542),
  })  : light = ColorScheme.fromSeed(
          seedColor: seedColor,
        ),
        dark = ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: seedColor,
        );

  final Color seedColor;

  late ColorScheme light;
  late ColorScheme dark;
}
