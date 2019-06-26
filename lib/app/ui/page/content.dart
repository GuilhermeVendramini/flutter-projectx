import 'package:flutter/material.dart';
import 'package:projetcx/app/models/page.dart';
import 'package:projetcx/app/widgets/utils/options_button.dart';

class PageContent extends StatefulWidget {
  final PageModel _page;

  PageContent(this._page);

  @override
  _PageContentState createState() => _PageContentState();
}

class _PageContentState extends State<PageContent>
    with TickerProviderStateMixin {
  AnimationController _controller;

  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Stack(
        children: <Widget>[
          OptionsButton(_controller),
          OptionEditButton(_controller),
          OptionReorderButton(_controller),
          OptionDeleteButton(_controller, widget._page),
          _content(),
        ],
      ),
    );
  }

  Widget _content() {
    return Positioned(
      child: Container(
        padding: EdgeInsets.all(40.0),
        child: Text('Body'),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
