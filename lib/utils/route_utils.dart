import 'package:akzonobel/home_page/home_screen.dart';
import 'package:akzonobel/login/login_page.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGeneratesAppRoutes(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case LoginScreen.route:
      return MaterialPageRoute(builder: (context) => LoginScreen());

    case HomeScreen.route:
      return MaterialPageRoute(builder: (context) => HomeScreen());

    default:
      return MaterialPageRoute(
        builder:
            (context) => Scaffold(
              body: Center(
                child: Text('No route defined for ${routeSettings.name}'),
              ),
            ),
      );
  }
}
