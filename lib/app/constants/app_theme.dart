import 'package:flutter/material.dart';
import 'package:projetcx/app/constants/app_colors.dart';

final ThemeData themeData = new ThemeData(
    fontFamily: 'ProductSans',
    brightness: Brightness.light,
    primarySwatch: MaterialColor(
        AppColors.green[500].value, AppColors.green),
    primaryColor: AppColors.green[500],
    primaryColorBrightness: Brightness.light,
    accentColor: AppColors.green[500],
    accentColorBrightness: Brightness.light
);