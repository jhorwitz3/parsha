import 'package:flutter/material.dart';
import 'package:parsha/screens/code.dart';
import 'package:parsha/screens/home.dart';
import 'package:parsha/screens/phone.dart';

Map<String, WidgetBuilder> routes = {
  //Routes
  '/home': (context) => const HomeScreen(),
  '/phone': (context) => const PhoneNumberFormScreen(),
  '/code': (context) => const PhoneCodeFormScreen(),
};
