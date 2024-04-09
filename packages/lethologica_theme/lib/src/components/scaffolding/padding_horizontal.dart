import 'package:flutter/material.dart';
import 'package:lethologica_theme/lethologica_theme.dart';

class PaddingHorizontal extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const PaddingHorizontal([this.value]);

  final double? value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: value ?? Spacing.value);
  }
}
