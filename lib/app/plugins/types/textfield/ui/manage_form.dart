import 'package:flutter/material.dart';
import 'package:projetcx/app/constants/app_colors.dart';
import 'package:projetcx/app/models/page.dart';
import 'package:projetcx/app/plugins/types/textfield/controllers/textfield.dart';
import 'package:projetcx/app/ui/page/manage_form.dart';
import 'package:projetcx/app/widgets/fields/text_field.dart';
import 'package:projetcx/app/widgets/utils/gradient_background.dart';
import 'package:provider/provider.dart';

class PluginTextFieldManageForm extends StatefulWidget {
  final PageModel item;

  PluginTextFieldManageForm({this.item});

  @override
  _PluginTextFieldManageFormState createState() =>
      _PluginTextFieldManageFormState();
}

class _PluginTextFieldManageFormState extends State<PluginTextFieldManageForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'parent': null,
    'value': null,
    'weight': 0,
  };

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: LayoutBuilder(builder: (context, constraints) {
          return SafeArea(
            child: GradientBackground(
              color: widget.item?.color != null
                  ? AppColors.getColorFrom(id: widget.item.color)
                  : Colors.blueGrey,
              child: Center(
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: _pluginForm(),
                      ),
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
        widget.item != null
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
              await _submitFormSave(context);
              _submitFormRedirect(widget.item);
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
    _formData['parent'] = widget.item.id;
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

  void _submitFormRedirect(PageModel item) {
    Route route = MaterialPageRoute(
      builder: (context) => PageManageForm(item: item),
    );
    Navigator.push(context, route);
  }

  Future<int> _submitFormSave(BuildContext context) async {
    final _pluginTextField = Provider.of<PluginTextFieldService>(context);
    _formKey.currentState.save();
    Future<int> result;

    result = _pluginTextField.addItem(_formData);
    return result;
  }
}
