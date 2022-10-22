import 'package:flutter/material.dart';
import 'package:medicine_app/screens/admin_page.dart';
import 'package:medicine_app/screens/home_page.dart';
import 'package:medicine_app/screens/info_page.dart';

abstract class RouteName {
  static const home = '/';
  static const admin = '/admin';
  static const info = '/info';
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case RouteName.admin:
        return MaterialPageRoute(builder: (_) => AdminPage());
      case RouteName.info:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => InfoPage(
            medicineId: args['id'],
            title1: args['title1'],
            title2: args['title2'],
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => Scaffold());
    }
  }
}
