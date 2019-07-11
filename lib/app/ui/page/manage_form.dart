import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:projetcx/app/constants/app_colors.dart';
import 'package:projetcx/app/constants/strings.dart';
import 'package:projetcx/app/controllers/page.dart';
import 'package:projetcx/app/models/page.dart';
import 'package:projetcx/app/plugins/controllers/plugins.dart';
import 'package:projetcx/app/plugins/models/plugin.dart';
import 'package:projetcx/app/plugins/models/plugin_data.dart';
import 'package:projetcx/app/plugins/register.dart';
import 'package:projetcx/app/plugins/ui/screen.dart';
import 'package:projetcx/app/ui/home/screen.dart';
import 'package:projetcx/app/widgets/fields/color_picker.dart';
import 'package:projetcx/app/widgets/fields/text_field.dart';
import 'package:projetcx/app/widgets/page/options_button.dart';
import 'package:projetcx/app/widgets/plugins/options_buttons.dart';
import 'package:projetcx/app/widgets/utils/gradient_background.dart';
import 'package:provider/provider.dart';

class PageManageForm extends StatefulWidget {
  final PageModel item;

  PageManageForm({this.item});

  @override
  State<StatefulWidget> createState() {
    return _PageManageFormState();
  }
}

class _PageManageFormState extends State<PageManageForm> {
  PageService _page;
  PluginService _plugin;
  List<PluginDataModel> _items = [];
  final Map<String, dynamic> _formData = {
    'name': null,
    'color': null,
    'weight': 99,
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Color _pageColor;
  int _pageIndex;

  @override
  void initState() {
    super.initState();
    setState(() {
      if (widget.item != null) {
        _pageColor = AppColors.getColorFrom(id: widget.item.color);
      } else {
        _pageColor = AppColors.defaultColors[0];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _page = Provider.of<PageService>(context);
    _plugin = Provider.of<PluginService>(context);

    if (_plugin.isItemsLoaded == null) {
      _plugin.loadItems();
    }

    _items = _plugin.getItemsByParent(widget.item?.id);

    _pageIndex = _page.getItemIndex(widget.item);

    if (_pageIndex == -1) {
      _pageIndex = _page.getItems.length;
    }

    return GradientBackground(
      color: _pageColor,
      child: WillPopScope(
        // ignore: missing_return
        onWillPop: () async {
          Route route = MaterialPageRoute(
            builder: (context) => HomeScreen(pageIndex: _pageIndex),
          );
          Navigator.push(context, route);
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: _pageColor,
            centerTitle: true,
            title: Text(Strings.managerPage),
          ),
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.all(40.0),
              child: _reorderableListView(_page, context),
            ),
          ),
          floatingActionButton: _floatingButtons(),
        ),
      ),
    );
  }

  Widget _floatingButtons() {
    return Stack(
      children: <Widget>[
        widget.item != null
            ? Padding(
                padding: EdgeInsets.only(left: 31),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: PageDeleteButton(widget.item),
                ),
              )
            : Container(),
        Align(
          alignment: Alignment.bottomRight,
          child: _saveButton(),
        ),
      ],
    );
  }

  Widget _saveButton() {
    return FloatingActionButton(
      heroTag: 'save',
      onPressed: () async {
        Future<PageModel> result = _submitFormSave();
        result.then((item) {
          _submitFormRedirect(context, _pageIndex);
        });
      },
      child: Icon(
        Icons.done,
      ),
    );
  }

  Widget _reorderableListView(PageService page, BuildContext context) {
    return ReorderableListView(
      onReorder: _onReorder,
      header: _formPage(page),
      children: _items != null
          ? _items.map((PluginDataModel item) => _listTile(item)).toList()
          : List(),
    );
  }

  Widget _formPage(PageService page) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.0,
          ),
          FieldColorPicker(
              color: _pageColor,
              onColorChanged: (color) {
                setState(() {
                  _pageColor = color;
                  _formData['color'] = _pageColor.value;
                });
              }),
          SizedBox(
            height: 20.0,
          ),
          FieldTextField(
            value: widget.item != null ? widget.item.name : null,
            hintText: Strings.fieldPageName,
            autoFocus: true,
            onSaved: (name) {
              setState(() {
                _formData['name'] = name != '' ? name : 'Page';
              });
            },
          ),
          SizedBox(
            height: 20.0,
          ),
          _addItemsButton(page, context),
          SizedBox(
            height: 40.0,
          ),
        ],
      ),
    );
  }

  Widget _listTile(PluginDataModel item) {
    PluginModel _pluginRegister =
        pluginsRegister.where((plugin) => plugin.type == item.type).first;

    void _actionDelete() async {
      await _plugin.deleteItem(item);
      setState(() {});
      Navigator.pop(context);
    }

    void _actionEdit() {
      _plugin.setCurrentParent(widget.item);
      _plugin.setCurrentItem(item);
      Route route = MaterialPageRoute(
        builder: (context) => _pluginRegister.form,
      );
      Navigator.push(context, route);
    }

    return Slidable(
      key: Key(item.id.toString()),
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: ListTile(
        key: Key(item.id.toString()),
        title: Container(
          decoration: BoxDecoration(
              border: Border(
                  right: BorderSide(
            color: Colors.white.withOpacity(0.4),
          ))),
          child: _pluginRegister.display(item.data),
        ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Edit',
          color: Colors.blue.withOpacity(0.4),
          icon: Icons.edit,
          onTap: () => _actionEdit(),
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

  Widget _addItemsButton(PageService page, BuildContext context) {
    return Center(
      child: Container(
        height: 60.0,
        width: 200.0,
        child: RaisedButton(
          child: Text(
            Strings.itemsButton,
          ),
          onPressed: () async {
            Future<PageModel> result = _submitFormSave();
            result.then((item) {
              Route route = MaterialPageRoute(
                builder: (context) => PluginsScreen(item),
              );
              Navigator.push(context, route);
            });
          },
        ),
      ),
    );
  }

  Future<PageModel> _submitFormSave() async {
    final _page = Provider.of<PageService>(context);
    _formKey.currentState.save();
    PageModel result;
    Future<int> itemResult;
    if (widget.item != null) {
      PageModel updatedItem = PageModel(
        id: widget.item.id,
        name: _formData['name'],
        color: _pageColor.value,
        weight: widget.item.weight,
      );
      itemResult = _page.updateItem(updatedItem);
      await itemResult.then((_) {
        result = updatedItem;
      });
      _page.reorderItemList(updatedItem);
    } else {
      itemResult = _page.addItem(_formData);
      await itemResult.then((itemId) {
        result = PageModel(
          id: itemId,
          name: _formData['name'],
          color: _pageColor.value,
          weight: 0,
        );
      });
    }
    return result;
  }

  void _submitFormRedirect(BuildContext context, int pageIndex) {
    Route route = MaterialPageRoute(
      builder: (context) => HomeScreen(
        pageIndex: pageIndex,
      ),
    );
    Navigator.push(context, route);
  }

  void _onReorder(int oldIndex, int newIndex) async {
    PluginDataModel item;
    if (newIndex > _items.length) newIndex = _items.length;
    if (oldIndex < newIndex) newIndex--;

    item = _items[oldIndex];
    _items.remove(item);
    _items.insert(newIndex, item);

    for (var i = 0; i < _items.length; i++) {
      _items[i].weight = i;
      await _plugin.updateItem(_items[i]);
    }

    setState(() {});
  }
}
