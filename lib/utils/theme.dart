import 'package:flutter/material.dart';

class TTextTheme {
  TTextTheme._();

  static TextTheme lightTheme = TextTheme(
    displayMedium: TextStyle(
      color: Colors.black,
      fontFamily: 'Poppins',
      fontSize: 20,
      fontWeight: FontWeight.w500,
      letterSpacing: -1,
      wordSpacing: 3,
    ),

    bodyMedium: TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
    ),

    bodySmall: TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w300,
    ),

    labelSmall: TextStyle(
      color: Colors.grey[800],
      fontSize: 14,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w200,
    ),

    headlineSmall: TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
    ),

    labelMedium: TextStyle(
      color: Colors.grey,
      fontSize: 14,
      fontFamily: 'Poppins',
      // fontWeight: FontWeight.w300,
    ),

    titleMedium: TextStyle(
      color: Colors.grey[700],
      fontSize: 16,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w200,
    ),

    titleSmall: TextStyle(
      color: Colors.blue[800],
      fontSize: 14,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
    ),

    headlineMedium: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w300,
    ),
  );
}

class TElevatedButtonTheme {
  TElevatedButtonTheme._();

  static ElevatedButtonThemeData lightButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: TTextTheme.lightTheme.headlineSmall,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
    ),
  );
}
