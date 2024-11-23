import 'package:flutter/material.dart';

ThemeData buildThemeData(Color seedColor, Brightness brightness) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: brightness,
      ).primary,
      foregroundColor: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: brightness,
      ).onPrimary,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: brightness,
      ).secondary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: brightness,
        ).primaryContainer,
      ),
    ),
  );
}