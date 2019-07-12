import 'package:flutter/material.dart';
import 'package:projetcx/app/ui/category/list.dart';

class Routes {
  Routes._();

  //static variables
  static const String categories = '/categories';

  static final routes = <String, WidgetBuilder>{
    categories: (BuildContext context) => CategoryList(),
  };
}
