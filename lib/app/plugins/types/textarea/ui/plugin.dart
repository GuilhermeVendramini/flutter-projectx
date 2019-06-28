import 'package:flutter/material.dart';

class PluginTypeTextArea extends StatefulWidget {
  @override
  _PluginTypeTextAreaState createState() =>
      _PluginTypeTextAreaState();
}

class _PluginTypeTextAreaState extends State<PluginTypeTextArea> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: Text('Text Area'),
        ),
      ),
    );
  }
}
