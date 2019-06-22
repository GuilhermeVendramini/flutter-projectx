import 'package:flutter/material.dart';
import 'package:projetcx/app/constants/app_theme.dart';
import 'package:projetcx/app/constants/strings.dart';
import 'package:projetcx/app/routes.dart';
import 'package:projetcx/app/ui/home/home.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.appName,
      theme: themeData,
      routes: Routes.routes,
      home: HomeScreen(),
    );
  }
}
