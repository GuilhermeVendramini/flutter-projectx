import 'package:flutter/material.dart';
import 'package:projetcx/app/controllers/page.dart' as p;
import 'package:projetcx/app/models/page.dart';
import 'package:projetcx/app/ui/page/clean.dart';
import 'package:projetcx/app/ui/page/screen.dart';
import 'package:projetcx/app/utils/dynamic_color.dart';
import 'package:projetcx/app/utils/full_screen.dart';
import 'package:projetcx/app/widgets/utils/gradient_background.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  PageController _pageController;
  int _currentPageIndex = 0;
  bool _fullScreen = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _pageController = PageController(initialPage: 0, viewportFraction: 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final p.PageService _page = Provider.of<p.PageService>(context);

    if (_page.isItemsLoaded == null) {
      _page.loadItems();
    }

    final List<PageModel> _pages = _page.getItems;

    Color _backgroundColor =
        DynamicColor.getBackground(_pages, _currentPageIndex);

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
                  return PageScreen();
                }
              },
              itemCount: _pages.length + 1,
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
              if (_currentPageIndex != currentPage) {
                setState(() => _currentPageIndex = currentPage);
              }
            }
          },
          child: GestureDetector(
            child: _pageBuilder(),
            onDoubleTap: () {
              _fullScreen = _fullScreen ? false : true;
              FullScreen.setFullScreen(_fullScreen);
            },
          ),
        ),
      );
    }

    return GradientBackground(
      color: _backgroundColor,
      child: WillPopScope(
        onWillPop: () async {
          FullScreen.setFullScreen(false);
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: _fadeTransition(),
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
