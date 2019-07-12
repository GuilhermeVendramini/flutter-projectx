import 'package:flutter/material.dart';
import 'package:projetcx/app/models/page.dart';
import 'package:projetcx/app/ui/page/content.dart';

class PageScreen extends StatefulWidget {
  final PageModel page;

  PageScreen({@required this.page});

  @override
  _PageScreenState createState() => _PageScreenState();
}

class _PageScreenState extends State<PageScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: PageContent(widget.page),
      ),
    );
  }
}
