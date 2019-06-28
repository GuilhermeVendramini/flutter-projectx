import 'package:flutter/material.dart';

class PluginTypeTextField extends StatefulWidget {
  @override
  _PluginTypeTextFieldState createState() => _PluginTypeTextFieldState();
}

class _PluginTypeTextFieldState extends State<PluginTypeTextField> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: Text('Text Field'),
        ),
      ),
    );
  }
}
