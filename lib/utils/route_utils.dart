import 'package:akzonobel/home_page/bloc/home_page_event.dart';
import 'package:akzonobel/home_page/home_screen.dart';
import 'package:akzonobel/home_page/repository/home_repository.dart';
import 'package:akzonobel/login/login_page.dart';
import 'package:akzonobel/login/model/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home_page/bloc/home_page_bloc.dart';

Route<dynamic> onGeneratesAppRoutes(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case LoginScreen.route:
      return MaterialPageRoute(builder: (context) => LoginScreen());

    case HomeScreen.route:
      final userData = routeSettings.arguments as UserData;
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => HomePageBloc(
            homeRepository: context.read<HomeRepository>(),
          )..add(FetchEvent(type: '1', offset: '0')), // 👈 initial fetch event
          child: HomeScreen(userData: userData),
        ),
      );


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
