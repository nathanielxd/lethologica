import 'package:flutter/material.dart';
import 'package:lethologica_theme/lethologica_theme.dart';

class PaddingVertical extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const PaddingVertical([this.value]);

  final double? value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: value ?? Spacing.value);
  }
}
