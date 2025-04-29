import 'package:flutter/material.dart';

class TTextTheme
{
  TTextTheme._();

  static TextTheme lightTheme = TextTheme(
    displayMedium: TextStyle(
      color: Colors.black,
      fontFamily: 'Poppins',
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: -1,
      wordSpacing: 3,
    ),

    bodySmall: TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w300,
    ),

    labelSmall: TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w200,
    ),
  );
}


class TElevatedButtonTheme
{
  TElevatedButtonTheme._();

  static ElevatedButtonThemeData lightButtonTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
      textStyle: WidgetStatePropertyAll(TextStyle(color: Colors.white)),
      backgroundColor: WidgetStatePropertyAll(Colors.transparent),
      shadowColor: WidgetStatePropertyAll(Colors.transparent),
    ),
  );
}
