import 'package:flutter/material.dart';
import 'package:projetcx/app/ui/page/content.dart';

class PageScreen extends StatefulWidget {
  final Color gradientStart = Colors.purple[600];
  final Color gradientEnd = Colors.deepPurple[600];

  @override
  _PageScreenState createState() => _PageScreenState();
}

class _PageScreenState extends State<PageScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: PageContent(),
      ),
    );
  }
}
