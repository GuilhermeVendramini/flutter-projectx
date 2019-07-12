import 'package:flutter/material.dart';
import 'package:projetcx/app/controllers/category.dart' as p;
import 'package:projetcx/app/controllers/screen.dart' as s;
import 'package:projetcx/app/models/category.dart';
import 'package:projetcx/app/ui/category/clean.dart';
import 'package:projetcx/app/ui/category/screen.dart';
import 'package:projetcx/app/utils/dynamic_color.dart';
import 'package:projetcx/app/widgets/utils/gradient_background.dart';
import 'package:provider/provider.dart';

class CategoryList extends StatefulWidget {
  final int categoryIndex;

  CategoryList({this.categoryIndex = 0});

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  PageController _pageController;
  int _categoryIndex;
  int _addCategory = 1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _categoryIndex = widget.categoryIndex;
    _pageController = PageController(
        initialPage: _categoryIndex, keepPage: true, viewportFraction: 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final p.CategoryService _category = Provider.of<p.CategoryService>(context);
    final s.ScreenService _screen = Provider.of<s.ScreenService>(context);
    Color _backgroundColor = Colors.blueGrey;

    if (_category.isItemsLoaded == null) {
      _category.loadItems();
    }

    final List<CategoryModel> _categories = _category.getItems;

    if (_categories != null &&
        _categories.length + 1 != _categoryIndex &&
        _categoryIndex != -1) {
      _backgroundColor =
          DynamicColor.getBackground(_categories, _categoryIndex);
    }

    _controller.forward();

    Widget _categoryBuilder() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemBuilder: (BuildContext context, int index) {
                if (index == _categories.length) {
                  return CategoryClean();
                } else {
                  return CategoryScreen(_categories[index]);
                }
              },
              itemCount: _categories.length + _addCategory,
            ),
          ),
        ],
      );
    }

    FadeTransition _fadeTransition() {
      return FadeTransition(
        opacity: _animation,
        child: NotificationListener<ScrollNotification>(
          // ignore: missing_return
          onNotification: (notification) {
            if (notification is ScrollEndNotification) {
              int currentPage = _pageController.page.round().toInt();
              if (_categoryIndex != currentPage) {
                setState(() => _categoryIndex = currentPage);
              }
            }
          },
          child: _categoryBuilder(),
        ),
      );
    }

    return GradientBackground(
      color: _backgroundColor,
      child: WillPopScope(
        onWillPop: () async {
          _addCategory = 1;
          _screen.setFullScreen(false);
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: _categories != null
              ? _fadeTransition()
              : Center(
                  child: CircularProgressIndicator(),
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
