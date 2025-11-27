import 'package:flutter/material.dart';
import '../screens/login_screen_bac.dart';
import '../screens/register_screen_bac.dart';
import '../screens/home_screen_bac.dart';

class AppRoutesBac {
  static Map<String, WidgetBuilder> routes = {
    '/login': (context) => LoginScreenBac(),
    '/register': (context) => RegisterScreenBac(),
    '/home': (context) => HomeScreenBac(),
  };
}
