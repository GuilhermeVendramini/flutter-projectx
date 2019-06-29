import 'package:flutter/material.dart';

class AppColors {
  static const List<Color> defaultColors = [
    Colors.blueGrey,
    Colors.red,
    Colors.redAccent,
    Colors.pink,
    Colors.pinkAccent,
    Colors.purple,
    Colors.purpleAccent,
    Colors.deepPurple,
    Colors.indigo,
    Colors.indigoAccent,
    Colors.blue,
    Colors.blueAccent,
    Colors.lightBlue,
    Colors.lightBlueAccent,
    Colors.cyan,
    Colors.cyanAccent,
    Colors.teal,
    Colors.tealAccent,
    Colors.green,
    Colors.greenAccent,
    Colors.lightGreen,
    Colors.lightGreenAccent,
    Colors.lime,
    Colors.limeAccent,
    Colors.yellow,
    Colors.yellowAccent,
    Colors.amber,
    Colors.amberAccent,
    Colors.orange,
    Colors.deepOrangeAccent,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.black,
  ];

  static Map<int, Color> _colors = Map();

  static Map<int, Color> get colors {
    if (_colors.isNotEmpty) {
      return _colors;
    }

    defaultColors.forEach((color) {
      _colors[color.value] = color;
    });
    return _colors;
  }

  static Color getColorFrom({int id}) {
    return colors.containsKey(id) ? colors[id] : defaultColors[0];
  }
}
