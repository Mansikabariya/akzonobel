import 'package:akzonobel/utils/route_utils.dart';
import 'package:akzonobel/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_page/home_screen.dart';
import 'login/bloc/login_bloc.dart';
import 'login/login_page.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: onGeneratesAppRoutes,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: TTextTheme.lightTheme,
        elevatedButtonTheme: TElevatedButtonTheme.lightButtonTheme,
      ),
      debugShowCheckedModeBanner: false,
      home:  LoginScreen(),
    );
  }
}
