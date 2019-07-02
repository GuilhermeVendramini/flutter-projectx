import 'package:flutter/material.dart';

final Color primaryColor = Colors.blueGrey;
final Color secondaryColor = Colors.white;

final ThemeData themeData = new ThemeData(
  fontFamily: 'ProductSans',
  cursorColor: secondaryColor,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    elevation: 2.0,
    backgroundColor: primaryColor.withOpacity(0.4),
  ),
  canvasColor: primaryColor,
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    buttonColor: primaryColor.withOpacity(0.4),
  ),
  buttonColor: primaryColor.withOpacity(0.4),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(
      color: secondaryColor,
    ),
  ),
  appBarTheme: AppBarTheme(
    color: primaryColor,
  ),
  textTheme: TextTheme(
    body1: TextStyle(color: secondaryColor),
    body2: TextStyle(color: secondaryColor),
    button: TextStyle(color: secondaryColor),
    caption: TextStyle(color: secondaryColor),
    display1: TextStyle(color: secondaryColor),
    display2: TextStyle(color: secondaryColor),
    display3: TextStyle(color: secondaryColor),
    display4: TextStyle(color: secondaryColor),
    headline: TextStyle(color: secondaryColor),
    subhead: TextStyle(color: secondaryColor),
    title: TextStyle(color: secondaryColor),
  ),
);
