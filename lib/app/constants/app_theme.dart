import 'package:flutter/material.dart';

final ThemeData themeData = new ThemeData(
  fontFamily: 'ProductSans',
  cursorColor: Colors.white,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.blueGrey.withOpacity(0.4),
  ),
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    buttonColor: Colors.blueGrey.withOpacity(0.4),
  ),
  buttonColor: Colors.blueGrey.withOpacity(0.4),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(
      color: Colors.white,
    ),
  ),
  appBarTheme: AppBarTheme(
    color: Colors.blueGrey,
  ),
  textTheme: TextTheme(
    body1: TextStyle(color: Colors.white),
    body2: TextStyle(color: Colors.white),
    button: TextStyle(color: Colors.white),
    caption: TextStyle(color: Colors.white),
    display1: TextStyle(color: Colors.white),
    display2: TextStyle(color: Colors.white),
    display3: TextStyle(color: Colors.white),
    display4: TextStyle(color: Colors.white),
    headline: TextStyle(color: Colors.white),
    subhead: TextStyle(color: Colors.white),
    title: TextStyle(color: Colors.white),
  ),
);
