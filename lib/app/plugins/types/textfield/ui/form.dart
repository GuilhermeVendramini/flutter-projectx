import 'package:flutter/material.dart';
import 'package:projetcx/app/constants/app_colors.dart';
import 'package:projetcx/app/models/page.dart';
import 'package:projetcx/app/plugins/controllers/plugins.dart';
import 'package:projetcx/app/ui/page/manage_form.dart';
import 'package:projetcx/app/widgets/fields/text_field.dart';
import 'package:projetcx/app/widgets/utils/gradient_background.dart';
import 'package:provider/provider.dart';

class PluginTextFieldBuildForm extends StatefulWidget {
  @override
  _PluginTextFieldBuildFormState createState() =>
      _PluginTextFieldBuildFormState();
}

class _PluginTextFieldBuildFormState extends State<PluginTextFieldBuildForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'type': 'TEXTFIELD',
    'parent': null,
    'value': null,
    'weight': 0,
  };
  PluginService _plugin;
  PageModel _parent;

  @override
  Widget build(BuildContext context) {
    _plugin = Provider.of<PluginService>(context);
    _parent = _plugin.getCurrentItem;

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: LayoutBuilder(builder: (context, constraints) {
          return SafeArea(
            child: GradientBackground(
              color: _parent?.color != null
                  ? AppColors.getColorFrom(id: _parent.color)
                  : Colors.blueGrey,
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: _pluginForm(),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
        floatingActionButton: _floatingActionButton(),
      ),
    );
  }

  Widget _floatingActionButton() {
    return Stack(
      children: <Widget>[
        _parent != null
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

  Widget _pluginForm() {
    _formData['parent'] = _parent?.id;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.0,
          ),
          FieldTextField(
            //value: widget.value != null ? widget.value : null,
            autoFocus: true,
            onSaved: (value) {
              setState(() {
                _formData['value'] = value;
              });
            },
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
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