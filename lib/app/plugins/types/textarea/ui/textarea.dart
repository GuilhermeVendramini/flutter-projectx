import 'package:flutter/material.dart';

class PluginTextArea extends StatefulWidget {
  @override
  _PluginTextAreaState createState() => _PluginTextAreaState();
}

class _PluginTextAreaState extends State<PluginTextArea> {
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
