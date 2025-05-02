import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
    colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        surface: Color(0xff090343),
        onSurface: Color(0xff090343),
        onPrimary: Color(0xff090343),
        secondary: Colors.white,
        onSecondary: Colors.white,
        primary: Color(0xff086796),
        onError: Colors.red,
        error: Colors.red),
    useMaterial3: true,
    textTheme: const TextTheme(
        displayLarge: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 48),
        displayMedium: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        labelLarge: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
        labelMedium: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)));
