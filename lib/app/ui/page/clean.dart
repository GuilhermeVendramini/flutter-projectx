import 'package:flutter/material.dart';

class PageClean extends StatefulWidget {
  @override
  _PageCleanState createState() => _PageCleanState();
}

class _PageCleanState extends State<PageClean> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Text('Page Clean'),
      ),
    );
  }
}
