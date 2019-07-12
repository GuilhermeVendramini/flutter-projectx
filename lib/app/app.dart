import 'package:flutter/material.dart';
import 'package:simpleslider/app/constants/app_theme.dart';
import 'package:simpleslider/app/constants/strings.dart';
import 'package:simpleslider/app/controllers/page.dart';
import 'package:simpleslider/app/controllers/screen.dart';
import 'package:simpleslider/app/plugins/controllers/plugins.dart';
import 'package:simpleslider/app/routes.dart';
import 'package:simpleslider/app/ui/home/screen.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
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
      home: HomeScreen(),
    );
  }
}
