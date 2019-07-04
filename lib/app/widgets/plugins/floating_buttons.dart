import 'package:flutter/material.dart';
import 'package:projetcx/app/models/page.dart';
import 'package:projetcx/app/plugins/controllers/plugins.dart';
import 'package:provider/provider.dart';
import 'package:projetcx/app/ui/page/manage_form.dart';

class PluginsFloatingButtons extends StatelessWidget {
  final PageModel _parent;
  final GlobalKey<FormState> _formKey;
  final Map<String, dynamic> _formData;

  PluginsFloatingButtons(this._parent, this._formKey, this._formData);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        //_item != null?
        Padding(
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
        ),
        //: Container(),
        Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            heroTag: 'save',
            onPressed: () async {
              Future<int> result = _submitFormSave(context);
              result.then((_) {
                Route route = MaterialPageRoute(
                  builder: (context) => PageManageForm(item: _parent),
                );
                Navigator.push(context, route);
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
    _formKey.currentState.save();
    Future<int> itemResult;
    int result;

    itemResult = _plugin.addItem(_formData);
    await itemResult.then((itemId) {
      result = itemId;
    });
    return result;
  }
}