import 'package:flutter/material.dart';
import 'package:lethologica_theme/lethologica_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LethologicaStyleMaker with ChangeNotifier {
  LethologicaStyle currentStyle =
      LethologicaStyle(colorScheme: LethologicaColorScheme());

  late SharedPreferences _sharedPreferences;

  Future<void> initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    final cachedStyle = _sharedPreferences.getInt('currentStyle');

    if (cachedStyle != null) {
      currentStyle = LethologicaStyle.fromSeedColor(Color(cachedStyle));
      notifyListeners();
    }
  }

  void changeStyle(Color seedColor) {
    currentStyle = LethologicaStyle.fromSeedColor(seedColor);
    notifyListeners();
    _sharedPreferences.setInt('currentStyle', seedColor.value);
  }
}
