import 'package:flutter/material.dart';

extension ThemeContextExtension on BuildContext {
  getLargeTitle() {
    return Theme.of(this).textTheme.titleLarge;
  }

  getThemeObject() {
    return Theme.of(this);
  }
}
