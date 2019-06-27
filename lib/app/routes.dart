import 'package:flutter/material.dart';
import 'package:projetcx/app/ui/home/screen.dart';

class Routes {
  Routes._();

  //static variables
  static const String home = '/home';

  static final routes = <String, WidgetBuilder>{
    home: (BuildContext context) => HomeScreen(),
  };
}
