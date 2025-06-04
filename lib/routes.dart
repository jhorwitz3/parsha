import 'package:flutter/material.dart';
import 'package:parsha/screens/code.dart';
import 'package:parsha/screens/home.dart';
import 'package:parsha/screens/phone.dart';
import 'package:parsha/screens/single_favorite.dart';

Map<String, WidgetBuilder> routes = {
  //Routes
  '/home': (context) => const HomeScreen(),
  '/phone': (context) => const PhoneNumberFormScreen(),
  '/code': (context) => const PhoneCodeFormScreen(),
  '/favorite': (context) => const SingleFavoriteScreen(),
};
