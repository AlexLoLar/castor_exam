import 'package:castor_exam/features/authentication/presentation/pages/login_page.dart';
import 'package:castor_exam/core/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String initialRoute = '/';
  static const String login = '/login';
  static const String home = '/home';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => const LoginPage(),
      home: (context) => const HomePage(),
    };
  }
}
