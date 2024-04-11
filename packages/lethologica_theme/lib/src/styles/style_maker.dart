import 'package:flutter/material.dart';
import 'package:lethologica_theme/lethologica_theme.dart';

class LethologicaStyleMaker with ChangeNotifier {
  LethologicaStyle currentStyle =
      LethologicaStyle(colorScheme: LethologicaColorScheme());

  void changeStyle(Color seedColor) {
    currentStyle = LethologicaStyle.fromSeedColor(seedColor);
    notifyListeners();
  }
}
