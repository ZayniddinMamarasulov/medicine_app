import 'package:flutter/material.dart';
import 'package:medicine_app/screens/admin_page.dart';
import 'package:medicine_app/screens/home_page.dart';
import 'package:medicine_app/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: RouteName.home,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }



}
