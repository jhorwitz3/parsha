import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
    colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        surface: Color(0xff09197E),
        onSurface: Color(0xff09197E),
        onPrimary: Color(0xff09197E),
        secondary: Color(0xffF4F4FB),
        onSecondary: Color(0xffF4F4FB),
        primary: Color(0xff086796),
        tertiary: Color(0xff080648),
        onError: Colors.red,
        error: Colors.red),
    useMaterial3: true,
    textTheme: const TextTheme(
        displayLarge: TextStyle(
            color: Color(0xffF4F4FB),
            fontWeight: FontWeight.bold,
            fontSize: 36),
        displayMedium: TextStyle(
            color: Color(0xffF4F4FB),
            fontWeight: FontWeight.bold,
            fontSize: 18),
        labelLarge: TextStyle(
            color: Color(0xffF4F4FB),
            fontWeight: FontWeight.bold,
            fontSize: 36),
        labelMedium: TextStyle(
            color: Color(0xffF4F4FB),
            fontWeight: FontWeight.normal,
            fontSize: 18)));
