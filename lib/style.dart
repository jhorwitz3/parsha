import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
    colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xff090343),
        onPrimary: Color(0xff090343),
        secondary: Colors.white,
        onSecondary: Colors.white,
        surface: Color(0xff010F1D),
        onSurface: Color(0xff010F1D),
        onError: Colors.red,
        error: Colors.red),
    useMaterial3: true,
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 48),
      displayMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
    ));
