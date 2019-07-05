import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projetcx/app/constants/app_colors.dart';
import 'package:projetcx/app/models/page.dart';
import 'package:projetcx/app/plugins/controllers/plugins.dart';
import 'package:projetcx/app/plugins/types/textimage/models/textimage.dart';
import 'package:projetcx/app/widgets/plugins/floating_buttons.dart';
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
    'values': TextImageModel(
      title: '',
      content: '',
      image: '',
    ),
    'weight': 0,
  };
  PluginService _plugin;
  PageModel _parent;
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
    _parent = _plugin.getCurrentItem;
    _formData['parent'] = _parent?.id;
    _formData['values'].image = _image?.path;

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
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Title',
          ),
          onSaved: (value) {
            setState(() {
              _formData['values'].title = value;
            });
          },
        ),
        SizedBox(
          height: 20.0,
        ),
        TextFormField(
          //value: widget.value != null ? widget.value : null,
          keyboardType: TextInputType.multiline,
          maxLines: 5,
          decoration: InputDecoration(
            hintText: 'Long text',
          ),
          onSaved: (value) {
            setState(() {
              _formData['values'].content = value;
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
