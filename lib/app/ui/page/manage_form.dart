import 'package:flutter/material.dart';
import 'package:projetcx/app/constants/app_colors.dart';
import 'package:projetcx/app/constants/strings.dart';
import 'package:projetcx/app/controllers/page.dart';
import 'package:projetcx/app/models/page.dart';
import 'package:projetcx/app/plugins/controllers/plugins.dart';
import 'package:projetcx/app/plugins/models/plugin_data.dart';
import 'package:projetcx/app/plugins/ui/screen.dart';
import 'package:projetcx/app/ui/home/screen.dart';
import 'package:projetcx/app/widgets/fields/color_picker.dart';
import 'package:projetcx/app/widgets/fields/text_field.dart';
import 'package:projetcx/app/widgets/page/options_button.dart';
import 'package:projetcx/app/widgets/page/reorder_items.dart';
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
  final Map<String, dynamic> _formData = {
    'name': null,
    'color': null,
    'weight': 0,
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Color _pageColor;
  int pageIndex;

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
    final _page = Provider.of<PageService>(context);
    final PluginService _plugin = Provider.of<PluginService>(context);

    if (_plugin.isItemsLoaded == null) {
      _plugin.loadItems();
    }
    pageIndex = _page.getItemIndex(widget.item);

    return GradientBackground(
      color: _pageColor,
      child: WillPopScope(
        onWillPop: () async {
          Route route = MaterialPageRoute(
            builder: (context) => HomeScreen(pageIndex: pageIndex),
          );
          Navigator.push(context, route);
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: _pageForm(_page, context),
          ),
          floatingActionButton: Stack(
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
          ),
        ),
      ),
    );
  }

  Widget _saveButton() {
    return FloatingActionButton(
      heroTag: 'save',
      onPressed: () async {
        Future<PageModel> result = _submitFormSave();
        result.then((item) {
          _submitFormRedirect(context, pageIndex);
        });
      },
      child: Icon(
        Icons.done,
      ),
    );
  }

  Widget _pageForm(PageService page, BuildContext context) {
    final PluginService _plugin = Provider.of<PluginService>(context);
    List<PluginDataModel> _items;

    if (_plugin.isItemsLoaded == null) {
      _plugin.loadItems();
    }

    _items = _plugin.getItemsByParent(widget.item?.id);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
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
                    _formData['name'] = name;
                  });
                },
              ),
              SizedBox(
                height: 40.0,
              ),
              _addItemsButton(page, context),
              _items != null ? PageReorderItems(_items) : Container(),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
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

  void _submitFormRedirect(BuildContext context, int pageIndex) {
    Route route = MaterialPageRoute(
      builder: (context) => HomeScreen(
            pageIndex: pageIndex,
          ),
    );
    Navigator.push(context, route);
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
}
