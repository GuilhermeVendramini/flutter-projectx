import 'package:flutter/material.dart';
import 'package:projetcx/app/constants/strings.dart';
import 'package:projetcx/app/controllers/screen.dart' as s;
import 'package:projetcx/app/models/page.dart';
import 'package:projetcx/app/plugins/ui/screen.dart';
import 'package:provider/provider.dart';

class PageCleanItems extends StatefulWidget {
  final PageModel _page;

  PageCleanItems(this._page);

  @override
  _PageCleanItemsState createState() => _PageCleanItemsState();
}

class _PageCleanItemsState extends State<PageCleanItems> {
  Color color = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.0),
      height: 200.0,
      width: 200.0,
      child: SafeArea(
        child: InkWell(
          onTap: () {
            final s.ScreenService _screen =
                Provider.of<s.ScreenService>(context);
            _screen.setFullScreen(false);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PluginsScreen(widget._page),
              ),
            );
          },
          child: Card(
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.widgets,
                  size: 52.0,
                  color: color,
                ),
                Container(
                  height: 8.0,
                ),
                Text(
                  Strings.addItems,
                  style: TextStyle(color: color),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
