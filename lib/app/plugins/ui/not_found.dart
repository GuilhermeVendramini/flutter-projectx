import 'package:flutter/material.dart';

class PluginNotFound extends StatefulWidget {
  @override
  _PluginNotFoundState createState() => _PluginNotFoundState();
}

class _PluginNotFoundState extends State<PluginNotFound> {
  final Color color = Colors.blueGrey;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.block,
                    color: color,
                    size: 100.0,
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Text(
                    'Plugin not found',
                    style: TextStyle(
                      color: color,
                      fontSize: 28.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
