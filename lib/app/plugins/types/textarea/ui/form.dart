import 'package:flutter/material.dart';
import 'package:simpleslider/app/constants/app_colors.dart';
import 'package:simpleslider/app/constants/strings.dart';
import 'package:simpleslider/app/models/page.dart';
import 'package:simpleslider/app/plugins/controllers/plugins.dart';
import 'package:simpleslider/app/plugins/models/plugin_data.dart';
import 'package:simpleslider/app/plugins/types/textarea/models/textarea.dart';
import 'package:simpleslider/app/widgets/plugins/options_buttons.dart';
import 'package:simpleslider/app/widgets/utils/gradient_background.dart';
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
  PluginDataModel _currentItem;
  Color _pageColor;

  @override
  Widget build(BuildContext context) {
    _plugin = Provider.of<PluginService>(context);
    _parent = _plugin.getCurrentParent;
    _currentItem = _plugin.getCurrentItem;
    _pageColor = _parent?.color != null
        ? AppColors.getColorFrom(id: _parent.color)
        : Colors.blueGrey;

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: _pageColor,
          centerTitle: true,
          title: Text(Strings.addLongText),
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          return SafeArea(
            child: GradientBackground(
              color: _pageColor,
              child: SingleChildScrollView(
                child: Center(
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
            initialValue:
                _currentItem != null ? _currentItem.data['text'] : null,
            keyboardType: TextInputType.multiline,
            maxLines: 10,
            decoration: InputDecoration(
              hintText: Strings.longText,
            ),
            onSaved: (value) {
              setState(() {
                _formData['data'].text = value;
              });
            },
          ),
          SizedBox(
            height: 80.0,
          ),
        ],
      ),
    );
  }
}
