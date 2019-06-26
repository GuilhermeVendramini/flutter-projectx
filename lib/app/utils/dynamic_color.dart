import 'package:flutter/material.dart';
import 'package:projetcx/app/constants/app_colors.dart';

class DynamicColor {
  DynamicColor._();

  static Color getBackground(List<dynamic> items, int currentIndex) {
    final Color dynamicColor = items.isEmpty ||
            items.length == currentIndex
        ? Colors.blueGrey
        : AppColors.getColorFrom(id: items[currentIndex].color);

    return dynamicColor;
  }
}
