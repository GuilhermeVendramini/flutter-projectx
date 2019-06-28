import 'package:flutter/material.dart';
import 'package:projetcx/app/controllers/screen.dart' as s;
import 'package:projetcx/app/models/page.dart';
import 'package:projetcx/app/widgets/page/options_button.dart';
import 'package:provider/provider.dart';

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
    final s.ScreenService _screen = Provider.of<s.ScreenService>(context);
    return Container(
      padding: EdgeInsets.all(20.0),
      child: _screen.isFullScreen == false
          ? Stack(
              children: <Widget>[
                PageOptionsButton(_controller),
                PageOptionEditButton(_controller, widget._page),
                PageOptionReorderButton(_controller),
                PageOptionDeleteButton(_controller, widget._page),
                _content()
              ],
            )
          : Stack(
              children: <Widget>[
                _content(),
              ],
            ),
    );
  }

  Widget _content() {
    return Positioned(
      child: Container(
        padding: EdgeInsets.all(40.0),
        child: Text('Items display'),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
