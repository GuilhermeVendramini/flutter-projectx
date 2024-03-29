import 'package:flutter/material.dart';
import 'package:simpleslider/app/controllers/screen.dart' as s;
import 'package:simpleslider/app/models/page.dart';
import 'package:simpleslider/app/plugins/controllers/plugins.dart';
import 'package:simpleslider/app/plugins/models/plugin.dart';
import 'package:simpleslider/app/plugins/models/plugin_data.dart';
import 'package:simpleslider/app/plugins/register.dart';
import 'package:simpleslider/app/ui/page/clean_items.dart';
import 'package:simpleslider/app/widgets/page/options_button.dart';
import 'package:provider/provider.dart';

class PageContent extends StatefulWidget {
  final PageModel _page;

  PageContent(this._page);

  @override
  _PageContentState createState() => _PageContentState();
}

class _PageContentState extends State<PageContent>
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
    final s.ScreenService _screen = Provider.of<s.ScreenService>(context);
    return Container(
      padding: EdgeInsets.all(40.0),
      child: _screen.isFullScreen == false
          ? Stack(
              children: <Widget>[
                Positioned(
                  child: Center(
                    child: _itemsList(),
                  ),
                ),
                PageOptionsButton(_controller),
                PageOptionEditButton(_controller, widget._page),
                PageOptionReorderButton(_controller),
                PageOptionDeleteButton(_controller, widget._page),
              ],
            )
          : Stack(
              children: <Widget>[
                Positioned(
                  child: Center(
                    child: _itemsList(),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _itemsList() {
    PluginService _plugin = Provider.of<PluginService>(context);

    if (_plugin.isItemsLoaded == null) {
      _plugin.loadItems();
      return CircularProgressIndicator();
    }

    List<PluginDataModel> _items = _plugin.getItemsByParent(widget._page.id);

    if (_items != null) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: _items.length,
        itemBuilder: (BuildContext context, int index) {
          return _itemContent(_items[index]);
        },
      );
    }
    return PageCleanItems(widget._page);
  }

  Widget _itemContent(PluginDataModel item) {
    PluginModel _plugin =
        pluginsRegister.where((plugin) => plugin.type == item.type).first;
    return Container(
      alignment: Alignment.center,
      child: _plugin.display(item.data),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
