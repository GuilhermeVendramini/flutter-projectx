import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projetcx/app/constants/strings.dart';
import 'package:projetcx/app/models/page.dart';
import 'package:projetcx/app/plugins/controllers/plugins.dart';
import 'package:projetcx/app/plugins/models/plugin_data.dart';
import 'package:projetcx/app/ui/page/manage_form.dart';
import 'package:provider/provider.dart';

const Color color = Colors.white;

class PluginsFloatingButtons extends StatelessWidget {
  final PageModel _parent;
  final GlobalKey<FormState> _formKey;
  final Map<String, dynamic> _formData;

  PluginsFloatingButtons(this._parent, this._formKey, this._formData);

  @override
  Widget build(BuildContext context) {
    final PluginService _plugin = Provider.of<PluginService>(context);
    final PluginDataModel _currentItem = _plugin.getCurrentItem;

    return Stack(
      children: <Widget>[
        _currentItem != null
            ? Padding(
                padding: EdgeInsets.only(left: 31),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: FloatingActionButton(
                    heroTag: 'delete',
                    onPressed: () {},
                    child: Icon(
                      Icons.delete_outline,
                    ),
                  ),
                ),
              )
            : Container(),
        Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            heroTag: 'save',
            onPressed: () async {
              Future<int> result = _submitFormSave(context);
              result.then((value) {
                if(value == null) {
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text(Strings.formError)));
                } else {
                  Route route = MaterialPageRoute(
                    builder: (context) => PageManageForm(item: _parent),
                  );
                  Navigator.push(context, route);
                }

              });
            },
            child: Icon(
              Icons.done,
            ),
          ),
        ),
      ],
    );
  }

  Future<int> _submitFormSave(BuildContext context) async {
    final _plugin = Provider.of<PluginService>(context);
    final PluginDataModel _currentItem = _plugin.getCurrentItem;
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Future<int> itemResult;
      int result;

      if (_currentItem != null) {
        PluginDataModel _updatedItem = PluginDataModel(
          id: _currentItem.id,
          type: _currentItem.type,
          parent: _currentItem.parent,
          data: json.decode(json.encode(_formData['data'])),
          weight: _currentItem.weight,
        );
        itemResult = _plugin.updateItem(_updatedItem);
        await itemResult.then((itemId) {
          result = itemId;
        });
      } else {
        itemResult = _plugin.addItem(_formData);
        await itemResult.then((itemId) {
          result = itemId;
        });
      }
      return result;
    }
    return null;
  }
}

class PluginsFloatingButtonsDisable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            heroTag: 'saveDisable',
            child: Icon(
              Icons.done,
              color: Colors.grey,
            ),
            onPressed: () {
              pluginsShowDialog(context);
            },
          ),
        ),
      ],
    );
  }

  void pluginsShowDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black.withOpacity(0.2),
          title: Center(
            child: Text(Strings.unableSave),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(Strings.unableSaveMessage),
              SizedBox(
                height: 10.0,
              ),
              RaisedButton(
                color: color,
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class PluginsActionDelete extends StatelessWidget {
  final Function _action;

  PluginsActionDelete(this._action);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: 100.0,
      child: RaisedButton(
        color: color,
        child: Text(
          Strings.yes,
        ),
        onPressed: _action,
      ),
    );
  }
}

void pluginsShowDialog(BuildContext context, actionDelete) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.black.withOpacity(0.2),
        title: Center(
          child: Text(Strings.confirmDeleteBox),
        ),
        content: Wrap(
          alignment: WrapAlignment.center,
          children: <Widget>[
            PluginsActionDelete(actionDelete),
          ],
        ),
      );
    },
  );
}
