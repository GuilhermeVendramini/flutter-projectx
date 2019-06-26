import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:projetcx/app/constants/strings.dart';
import 'package:projetcx/app/controllers/page.dart' as p;
import 'package:projetcx/app/models/page.dart';
import 'package:projetcx/app/utils/device_media_query.dart';
import 'package:provider/provider.dart';

class PageReorder extends StatefulWidget {
  @override
  _PageReorderState createState() => _PageReorderState();
}

class _PageReorderState extends State<PageReorder> {
  List<PageModel> _pages = [];
  p.PageService _page;
  final Color _color = Colors.blueGrey;

  void _onReorder(int oldIndex, int newIndex) {
    PageModel item;
    setState(() {
      // These two lines are workarounds for ReorderableListView problems
      if (newIndex > _pages.length) newIndex = _pages.length;
      if (oldIndex < newIndex) newIndex--;
      item = _pages[oldIndex];
      item.weight = newIndex;
      _pages.remove(item);
      _pages.insert(newIndex, item);
    });
    _page.updateItem(item);
  }

  @override
  Widget build(BuildContext context) {
    _page = Provider.of<p.PageService>(context);
    final double _targetWidth =
        DeviceMediaQuery.getTargetWidth(MediaQuery.of(context).size.width);
    if (_page.isItemsLoaded == null) {
      _page.loadItems();
    }

    _pages = _page.getItems;

    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.pageTitleReorder),
      ),
      body: Center(
        child: Container(
          width: _targetWidth,
          child: Scrollbar(
            child: ReorderableListView(
              onReorder: _onReorder,
              padding: EdgeInsets.symmetric(vertical: 8.0),
              children: _pages
                  .map((PageModel item) => _buildListTile(context, item))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(BuildContext context, PageModel item) {
    return ListTile(
      key: Key(item.id.toString()),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            item.name,
            style: TextStyle(
              color: _color,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '${item.weight}',
            style: TextStyle(
              color: _color,
              fontWeight: FontWeight.w600,
            ),
          ),
          Icon(
            Icons.drag_handle,
            color: _color,
          ),
        ],
      ),
    );
  }
}
