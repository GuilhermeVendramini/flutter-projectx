import 'package:flutter/material.dart';
import 'package:projetcx/app/plugins/models/plugin_data.dart';

class PageReorderItems extends StatefulWidget {
  final List<PluginDataModel> _items;

  PageReorderItems(this._items);

  @override
  _PageReorderItemsState createState() => _PageReorderItemsState();
}

class _PageReorderItemsState extends State<PageReorderItems> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: _buildItem,
      itemCount: widget._items.length,
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return Text('${widget._items[index].value}');
  }
}
