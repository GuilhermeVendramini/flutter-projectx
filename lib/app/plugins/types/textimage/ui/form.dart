import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projetcx/app/constants/app_colors.dart';
import 'package:projetcx/app/models/page.dart';
import 'package:projetcx/app/plugins/controllers/plugins.dart';
import 'package:projetcx/app/plugins/models/plugin_data.dart';
import 'package:projetcx/app/plugins/types/textimage/models/textimage.dart';
import 'package:projetcx/app/widgets/plugins/options_buttons.dart';
import 'package:projetcx/app/widgets/utils/gradient_background.dart';
import 'package:provider/provider.dart';

class PluginTextImageBuildForm extends StatefulWidget {
  @override
  _PluginTextImageBuildFormState createState() =>
      _PluginTextImageBuildFormState();
}

class _PluginTextImageBuildFormState extends State<PluginTextImageBuildForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'type': 'TEXTIMAGE',
    'parent': null,
    'data': TextImageModel(
      title: '',
      text: '',
      image: '',
    ),
    'weight': 0,
  };
  PluginService _plugin;
  PageModel _parent;
  PluginDataModel _currentItem;
  File _image;

  Future _getImage(ImageSource imageSource) async {
    var image = await ImagePicker.pickImage(source: imageSource);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    _plugin = Provider.of<PluginService>(context);
    _currentItem = _plugin.getCurrentItem;
    _parent = _plugin.getCurrentParent;
    _formData['parent'] = _parent?.id;
    _formData['data'].image = _image?.path;

    if (_currentItem != null && _image == null) {
      _formData['data'].image = _currentItem.data['image'];
      _image = File(_currentItem.data['image']);
    }

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: GradientBackground(
        color: _parent?.color != null
            ? AppColors.getColorFrom(id: _parent.color)
            : Colors.blueGrey,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: LayoutBuilder(
            builder: (context, constraints) {
              return SafeArea(
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          _imageButtons(),
                          SizedBox(
                            height: 20.0,
                          ),
                          _pluginGrid(),
                        ],
                      ),
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
          _textColumn(),
          _imageColumn(),
        ],
      ),
    );
  }

  Widget _imageColumn() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(20.0),
      child: _image == null ? Text('No image selected.') : Image.file(_image),
    );
  }

  Widget _textColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextFormField(
          initialValue:
              _currentItem != null ? _currentItem.data['title'] : null,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Title',
          ),
          onSaved: (value) {
            setState(() {
              _formData['data'].title = value;
            });
          },
        ),
        SizedBox(
          height: 20.0,
        ),
        TextFormField(
          initialValue: _currentItem != null ? _currentItem.data['text'] : null,
          keyboardType: TextInputType.multiline,
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
      ],
    );
  }

  Widget _imageButtons() {
    return Column(
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
              onPressed: () => _getImage(ImageSource.camera),
              child: Icon(Icons.add_a_photo),
            ),
            SizedBox(
              width: 20.0,
            ),
            RaisedButton(
              onPressed: () => _getImage(ImageSource.gallery),
              child: Icon(Icons.image),
            ),
          ],
        ),
        SizedBox(
          height: 20.0,
        ),
      ],
    );
  }
}
