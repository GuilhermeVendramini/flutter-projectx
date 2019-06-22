import 'package:flutter/material.dart';
import 'package:projetcx/app/ui/page/clean.dart';
import 'package:projetcx/app/ui/page/screen.dart';
import 'package:projetcx/app/widgets/gradient_background.dart';

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
    Color backgroundColor = Colors.blueGrey;

    if (_currentPageIndex == 0) {
      backgroundColor = Colors.orange;
    } else if (_currentPageIndex == 1) {
      backgroundColor = Colors.deepPurple;
    } else if (_currentPageIndex == 2) {
      backgroundColor = Colors.teal;
    }

    _controller.forward();

    return GradientBackground(
      color: backgroundColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FadeTransition(
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 3) {
                        return PageClean();
                      } else {
                        return PageScreen();
                      }
                    },
                    itemCount: 3 + 1,
                  ),
                ),
              ],
            ),
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
