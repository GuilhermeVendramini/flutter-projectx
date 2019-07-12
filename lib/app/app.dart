import 'package:flutter/material.dart';
import 'package:projetcx/app/constants/app_theme.dart';
import 'package:projetcx/app/constants/strings.dart';
import 'package:projetcx/app/controllers/category.dart';
import 'package:projetcx/app/controllers/page.dart';
import 'package:projetcx/app/controllers/screen.dart';
import 'package:projetcx/app/plugins/controllers/plugins.dart';
import 'package:projetcx/app/routes.dart';
import 'package:projetcx/app/ui/category/list.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CategoryService>(builder: (_) => CategoryService()),
        ChangeNotifierProvider<PageService>(builder: (_) => PageService()),
        ChangeNotifierProvider<ScreenService>(builder: (_) => ScreenService()),
        ChangeNotifierProvider<PluginService>(builder: (_) => PluginService()),
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
      home: CategoryList(),
    );
  }
}
