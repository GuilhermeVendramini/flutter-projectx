import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:simpleslider/app/constants/app_colors.dart';
import 'package:simpleslider/app/constants/strings.dart';
import 'package:simpleslider/app/controllers/page.dart' as p;
import 'package:simpleslider/app/models/page.dart';
import 'package:simpleslider/app/ui/page/manage_form.dart';
import 'package:simpleslider/app/utils/device_media_query.dart';
import 'package:simpleslider/app/widgets/plugins/options_buttons.dart';
import 'package:provider/provider.dart';

class PageReorder extends StatefulWidget {
  @override
  _PageReorderState createState() => _PageReorderState();
}

class _PageReorderState extends State<PageReorder> {
  List<PageModel> _pages = [];
  p.PageService _page;

  final Color _color = Colors.white;

  void _onReorder(int oldIndex, int newIndex) async {
    PageModel item;
    if (newIndex > _pages.length) newIndex = _pages.length;
    if (oldIndex < newIndex) newIndex--;

    item = _pages[oldIndex];
    _pages.remove(item);
    _pages.insert(newIndex, item);

    for (var i = 0; i < _pages.length; i++) {
      _pages[i].weight = i;
      await _page.updateItem(_pages[i]);
    }

    setState(() {});
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
                  .map((PageModel item) => _slidable(context, item))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _slidable(BuildContext context, PageModel item) {
    void _actionDelete() async {
      await _page.deleteItem(item);
      setState(() {});
      Navigator.pop(context);
    }

    return Slidable(
      key: Key(item.id.toString()),
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: _listTile(context, item),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Edit',
          color: Colors.blue.withOpacity(0.4),
          icon: Icons.edit,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PageManageForm(item: item),
              ),
            );
          },
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red.withOpacity(0.4),
          icon: Icons.delete,
          onTap: () {
            pluginsShowDialog(context, _actionDelete);
          },
        ),
      ],
    );
  }

  Widget _listTile(BuildContext context, PageModel item) {
    return ListTile(
      key: Key(item.id.toString()),
      title: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              Container(
                width: 20.0,
                height: 20.0,
                decoration: BoxDecoration(
                  border: Border.all(color: _color),
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.getColorFrom(id: item.color),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                item.name,
                style: TextStyle(
                  color: _color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
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
