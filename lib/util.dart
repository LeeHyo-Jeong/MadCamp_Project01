import 'package:flutter/material.dart';

TextTheme createTextTheme(
    BuildContext context) {
  String bodyFontString = "Alata";
  String displayFontString = "Alkatra";
  TextTheme baseTextTheme = Theme.of(context).textTheme;
  TextTheme textTheme = baseTextTheme.copyWith(
    bodyLarge: TextStyle(fontFamily: bodyFontString),
    bodyMedium: TextStyle(fontFamily: bodyFontString),
    bodySmall: TextStyle(fontFamily: bodyFontString),
    labelLarge: TextStyle(fontFamily: bodyFontString),
    labelMedium: TextStyle(fontFamily: bodyFontString),
    labelSmall: TextStyle(fontFamily: bodyFontString),
    displayLarge: TextStyle(fontFamily: displayFontString),
    displayMedium: TextStyle(fontFamily: displayFontString),
    displaySmall: TextStyle(fontFamily: displayFontString),
    headlineLarge: TextStyle(fontFamily: displayFontString),
    headlineMedium: TextStyle(fontFamily: displayFontString),
    headlineSmall: TextStyle(fontFamily: displayFontString),
    titleLarge: TextStyle(fontFamily: displayFontString),
    titleMedium: TextStyle(fontFamily: displayFontString),
    titleSmall: TextStyle(fontFamily: displayFontString),
  );
  return textTheme;
}
