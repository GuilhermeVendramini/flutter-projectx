import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projetcx/app/constants/app_colors.dart';
import 'package:projetcx/app/models/page.dart';
import 'package:projetcx/app/plugins/controllers/plugins.dart';
import 'package:projetcx/app/widgets/plugins/floating_buttons.dart';
import 'package:projetcx/app/widgets/utils/gradient_background.dart';
import 'package:provider/provider.dart';

class PluginImageFieldBuildForm extends StatefulWidget {
  @override
  _PluginImageFieldBuildFormState createState() =>
      _PluginImageFieldBuildFormState();
}

class _PluginImageFieldBuildFormState extends State<PluginImageFieldBuildForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'type': 'IMAGEFIELD',
    'parent': null,
    'value': null,
    'weight': 0,
  };
  PluginService _plugin;
  PageModel _parent;
  File _image;

  Future getImage(ImageSource imageSource) async {
    var image = await ImagePicker.pickImage(source: imageSource);
    _formData['value'] = image.path;
    setState(() {
      _image = image;
    });
  }

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
              child: SingleChildScrollView(
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: () => getImage(ImageSource.camera),
                child: Icon(Icons.add_a_photo),
              ),
              SizedBox(
                width: 20.0,
              ),
              RaisedButton(
                onPressed: () => getImage(ImageSource.gallery),
                child: Icon(Icons.image),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            child: _image == null
                ? Text('No image selected.')
                : Image.file(_image),
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
