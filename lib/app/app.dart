import 'package:flutter/material.dart';
import 'package:projetcx/app/constants/app_theme.dart';
import 'package:projetcx/app/constants/strings.dart';
import 'package:projetcx/app/controllers/page.dart';
import 'package:projetcx/app/routes.dart';
import 'package:projetcx/app/ui/home/home.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PageService>(builder: (_) => PageService()),
      ],
      child: _runMaterialApp(),
    );
  }

  Widget _runMaterialApp() {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.appName,
      theme: themeData,
      routes: Routes.routes,
      home: HomeScreen(),
    );
  }
}
