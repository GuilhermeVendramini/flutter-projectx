import 'package:flutter/material.dart';
import 'package:projetcx/app/controllers/page.dart' as p;
import 'package:projetcx/app/controllers/screen.dart' as s;
import 'package:projetcx/app/models/page.dart';
import 'package:projetcx/app/ui/page/clean.dart';
import 'package:projetcx/app/ui/page/screen.dart';
import 'package:projetcx/app/utils/dynamic_color.dart';
import 'package:projetcx/app/widgets/utils/gradient_background.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final int pageIndex;

  HomeScreen({this.pageIndex = 0});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  PageController _pageController;
  int _pageIndex;
  bool _fullScreen = true;
  int _addPage = 1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _pageIndex = widget.pageIndex;
    _pageController = PageController(
        initialPage: _pageIndex, keepPage: true, viewportFraction: 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final p.PageService _page = Provider.of<p.PageService>(context);
    final s.ScreenService _screen = Provider.of<s.ScreenService>(context);
    Color _backgroundColor = Colors.blueGrey;

    if (_page.isItemsLoaded == null) {
      _page.loadItems();
    }

    final List<PageModel> _pages = _page.getItems;

    if (_pages != null && _pages.length + 1 != _pageIndex) {
      _backgroundColor = DynamicColor.getBackground(_pages, _pageIndex);
    }

    _controller.forward();

    Widget _pageBuilder() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemBuilder: (BuildContext context, int index) {
                if (index == _pages.length) {
                  return PageClean();
                } else {
                  return PageScreen(_pages[index]);
                }
              },
              itemCount: _pages.length + _addPage,
            ),
          ),
        ],
      );
    }

    FadeTransition _fadeTransition() {
      return FadeTransition(
        opacity: _animation,
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollEndNotification) {
              int currentPage = _pageController.page.round().toInt();
              if (_pageIndex != currentPage) {
                setState(() => _pageIndex = currentPage);
              }
            }
          },
          child: GestureDetector(
            child: _pageBuilder(),
            onDoubleTap: () {
              _fullScreen = _fullScreen ? false : true;
              _screen.setFullScreen(_fullScreen);
              setState(() {
                _addPage = _fullScreen ? 0 : 1;
              });
            },
          ),
        ),
      );
    }

    return GradientBackground(
      color: _backgroundColor,
      child: WillPopScope(
        onWillPop: () async {
          _addPage = 1;
          _screen.setFullScreen(false);
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: _pages != null
              ? _fadeTransition()
              : Center(
                  child: CircularProgressIndicator(),
                ),
          floatingActionButton:
              _screen.isFullScreen || _pageIndex == _pages.length
                  ? Container()
                  : FloatingActionButton(
                      heroTag: 'fullScreen',
                      onPressed: () {
                        setState(() {
                          _addPage = 0;
                        });
                        _screen.setFullScreen(true);
                      },
                      child: Icon(
                        Icons.fullscreen,
                      ),
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                    ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
