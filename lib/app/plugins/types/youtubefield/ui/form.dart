import 'package:flutter/material.dart';
import 'package:projetcx/app/constants/app_colors.dart';
import 'package:projetcx/app/constants/strings.dart';
import 'package:projetcx/app/models/page.dart';
import 'package:projetcx/app/plugins/controllers/plugins.dart';
import 'package:projetcx/app/plugins/models/plugin_data.dart';
import 'package:projetcx/app/plugins/types/youtubefield/models/youtubefield.dart';
import 'package:projetcx/app/widgets/plugins/options_buttons.dart';
import 'package:projetcx/app/widgets/utils/gradient_background.dart';
import 'package:provider/provider.dart';

class PluginYoutubeFieldBuildForm extends StatefulWidget {
  @override
  _PluginYoutubeFieldBuildFormState createState() =>
      _PluginYoutubeFieldBuildFormState();
}

class _PluginYoutubeFieldBuildFormState
    extends State<PluginYoutubeFieldBuildForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'type': 'YOUTUBEFIELD',
    'parent': null,
    'data': YoutubeFieldModel(
      videoId: '',
      width: null,
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
          title: Text(Strings.addYoutube),
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          return SafeArea(
            child: GradientBackground(
              color: _pageColor,
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
            initialValue:
                _currentItem != null ? _currentItem.data['videoId'] : null,
            autofocus: true,
            decoration: InputDecoration(
              hintText: Strings.youtubeId,
            ),
            onSaved: (value) {
              setState(() {
                _formData['data'].videoId = value;
              });
            },
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            initialValue:
                _currentItem != null && _currentItem.data['width'] != null
                    ? _currentItem.data['width'].toString()
                    : null,
            decoration: InputDecoration(
              hintText: Strings.youtubeWidth,
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onSaved: (value) {
              setState(() {
                _formData['data'].width =
                    value == '' ? null : double.tryParse(value);
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
