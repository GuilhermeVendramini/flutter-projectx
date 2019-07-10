import 'package:flutter/material.dart';
import 'package:projetcx/app/constants/app_colors.dart';
import 'package:projetcx/app/constants/strings.dart';
import 'package:projetcx/app/models/page.dart';
import 'package:projetcx/app/plugins/controllers/plugins.dart';
import 'package:projetcx/app/plugins/models/plugin_data.dart';
import 'package:projetcx/app/plugins/types/text_columns/models/text_columns.dart';
import 'package:projetcx/app/widgets/plugins/options_buttons.dart';
import 'package:projetcx/app/widgets/utils/gradient_background.dart';
import 'package:provider/provider.dart';

class PluginTextColumnsBuildForm extends StatefulWidget {
  @override
  _PluginTextColumnsBuildFormState createState() =>
      _PluginTextColumnsBuildFormState();
}

class _PluginTextColumnsBuildFormState extends State<PluginTextColumnsBuildForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'type': 'TEXTCOLUMNS',
    'parent': null,
    'data': TextColumnsModel(
      titleOne: '',
      titleTwo: '',
      textOne: '',
      textTwo: '',
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
    _currentItem = _plugin.getCurrentItem;
    _parent = _plugin.getCurrentParent;
    _formData['parent'] = _parent?.id;

    _pageColor = _parent?.color != null
        ? AppColors.getColorFrom(id: _parent.color)
        : Colors.blueGrey;

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: GradientBackground(
        color: _pageColor,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: _pageColor,
            centerTitle: true,
            title: Text(Strings.addTextColumns),
          ),
          backgroundColor: Colors.transparent,
          body: LayoutBuilder(
            builder: (context, constraints) {
              return SafeArea(
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: _pluginGrid(),
                    ),
                  ),
                ),
              );
            },
          ),
          floatingActionButton:
              PluginsFloatingButtons(_parent, _formKey, _formData),
        ),
      ),
    );
  }

  Widget _pluginGrid() {
    return Form(
      key: _formKey,
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        children: <Widget>[
          _columnOne(),
          _columnTwo(),
        ],
      ),
    );
  }

  Widget _titleOne() {
    return TextFormField(
      initialValue:
      _currentItem != null ? _currentItem.data['titleOne'] : null,
      decoration: InputDecoration(
        hintText: Strings.title,
      ),
      onSaved: (value) {
        setState(() {
          _formData['data'].titleOne = value;
        });
      },
    );
  }

  Widget _textOne() {
    return TextFormField(
      initialValue:
      _currentItem != null ? _currentItem.data['textOne'] : null,
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      decoration: InputDecoration(
        hintText: Strings.longText,
      ),
      onSaved: (value) {
        setState(() {
          _formData['data'].textOne = value;
        });
      },
    );
  }

  Widget _columnOne() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(right: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _titleOne(),
          SizedBox(
            height: 20.0,
          ),
          _textOne(),
        ],
      ),
    );
  }

  Widget _titleTwo() {
    return TextFormField(
      initialValue:
      _currentItem != null ? _currentItem.data['titleTwo'] : null,
      autofocus: true,
      decoration: InputDecoration(
        hintText: Strings.title,
      ),
      onSaved: (value) {
        setState(() {
          _formData['data'].titleTwo = value;
        });
      },
    );
  }

  Widget _textTwo() {
    return TextFormField(
      initialValue:
      _currentItem != null ? _currentItem.data['textTwo'] : null,
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      decoration: InputDecoration(
        hintText: Strings.longText,
      ),
      onSaved: (value) {
        setState(() {
          _formData['data'].textTwo = value;
        });
      },
    );
  }

  Widget _columnTwo() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _titleTwo(),
          SizedBox(
            height: 20.0,
          ),
          _textTwo(),
        ],
      ),
    );
  }
}
