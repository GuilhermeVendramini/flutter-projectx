import 'package:flutter/material.dart';
import 'package:projetcx/app/models/category.dart';
import 'package:projetcx/app/ui/page/list.dart';

//import 'package:projetcx/app/ui/category/clean_items.dart';
//import 'package:projetcx/app/widgets/category/options_button.dart';
//import 'package:provider/provider.dart';

class CategoryContent extends StatefulWidget {
  final CategoryModel category;

  CategoryContent({@required this.category});

  @override
  _CategoryContentState createState() => _CategoryContentState();
}

class _CategoryContentState extends State<CategoryContent>
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
    return InkWell(
      child: Stack(
        children: <Widget>[
          _categoryContent(),
          //CategoryOptionsButton(_controller),
          //CategoryOptionEditButton(_controller, widget._category),
          //CategoryOptionDeleteButton(_controller, widget._category),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PageList(category: widget.category),
          ),
        );
      },
    );
  }

  Widget _categoryContent() {
    return Positioned(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(40.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                IconData(
                  widget.category.icon,
                  fontFamily: 'MaterialIcons',
                ),
                color: Colors.white,
                size: 52.0,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Text(
              widget.category.name.toUpperCase(),
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
