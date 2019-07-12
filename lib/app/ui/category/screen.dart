import 'package:flutter/material.dart';
import 'package:projetcx/app/models/category.dart';
import 'package:projetcx/app/ui/category/content.dart';

class CategoryScreen extends StatefulWidget {
  final Color gradientStart = Colors.purple[600];
  final Color gradientEnd = Colors.deepPurple[600];
  final CategoryModel _category;

  CategoryScreen(this._category);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: CategoryContent(category: widget._category),
      ),
    );
  }
}
