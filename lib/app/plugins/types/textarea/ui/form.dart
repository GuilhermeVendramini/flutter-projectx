import 'package:flutter/material.dart';
import 'package:projetcx/app/constants/app_colors.dart';
import 'package:projetcx/app/models/page.dart';
import 'package:projetcx/app/plugins/controllers/plugins.dart';
import 'package:projetcx/app/plugins/types/textarea/models/textarea.dart';
import 'package:projetcx/app/widgets/plugins/options_buttons.dart';
import 'package:projetcx/app/widgets/utils/gradient_background.dart';
import 'package:provider/provider.dart';

class PluginTextAreaBuildForm extends StatefulWidget {
  @override
  _PluginTextAreaBuildFormState createState() =>
      _PluginTextAreaBuildFormState();
}

class _PluginTextAreaBuildFormState extends State<PluginTextAreaBuildForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'type': 'TEXTAREA',
    'parent': null,
    'data': TextAreaModel(
      text: '',
    ),
    'weight': 0,
  };
  PluginService _plugin;
  PageModel _parent;

  @override
  Widget build(BuildContext context) {
    _plugin = Provider.of<PluginService>(context);
    _parent = _plugin.getCurrentParent;

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
        floatingActionButton:
            PluginsFloatingButtons(_parent, _formKey, _formData),
      ),
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
          TextFormField(
            //value: widget.value != null ? widget.value : null,
            keyboardType: TextInputType.multiline,
            autofocus: true,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Long text',
            ),
            onSaved: (value) {
              setState(() {
                _formData['data'].text = value;
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
}
