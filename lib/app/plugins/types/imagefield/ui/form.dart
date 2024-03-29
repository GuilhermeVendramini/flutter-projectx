import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simpleslider/app/constants/app_colors.dart';
import 'package:simpleslider/app/constants/strings.dart';
import 'package:simpleslider/app/models/page.dart';
import 'package:simpleslider/app/plugins/controllers/plugins.dart';
import 'package:simpleslider/app/plugins/models/plugin_data.dart';
import 'package:simpleslider/app/plugins/types/imagefield/models/imagefield.dart';
import 'package:simpleslider/app/widgets/plugins/options_buttons.dart';
import 'package:simpleslider/app/widgets/utils/gradient_background.dart';
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
    'data': ImageFieldModel(
      image: '',
      height: null,
      width: null,
    ),
    'weight': 0,
  };
  PluginService _plugin;
  PageModel _parent;
  PluginDataModel _currentItem;
  File _image;
  bool _currentFileVerified = false;
  Color _pageColor;

  Future _getImage(ImageSource imageSource) async {
    var image = await ImagePicker.pickImage(source: imageSource);
    setState(() {
      _image = image;
    });
  }

  _getCurrentFile() {
    _currentFileVerified = true;
    final Future<bool> _fileExists = File(_currentItem.data['image']).exists();
    _fileExists.then((result) {
      if (result) {
        setState(() {
          _image = File(_currentItem.data['image']);
        });
      } else {
        setState(() {
          _image = null;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _plugin = Provider.of<PluginService>(context);
    _currentItem = _plugin.getCurrentItem;
    _parent = _plugin.getCurrentParent;
    _formData['data'].image = _image?.path;

    if (_currentItem != null &&
        _image == null &&
        _currentFileVerified == false) {
      _formData['data'].image = _currentItem.data['image'];
      _getCurrentFile();
    }

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
          title: Text(Strings.addImage),
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
        floatingActionButton: _image != null
            ? PluginsFloatingButtons(_parent, _formKey, _formData)
            : PluginsFloatingButtonsDisable(),
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
          Container(
            child: _image == null ? Text(Strings.noImage) : Image.file(_image),
          ),
          SizedBox(
            height: 20.0,
          ),
          _imageHeight(),
          SizedBox(
            height: 20.0,
          ),
          _imageWidth(),
          SizedBox(
            height: 80.0,
          ),
        ],
      ),
    );
  }

  Widget _imageHeight() {
    return TextFormField(
      initialValue: _currentItem != null && _currentItem.data['height'] != null
          ? _currentItem.data['height'].toString()
          : null,
      decoration: InputDecoration(
        hintText: Strings.imageHeight,
      ),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      onSaved: (value) {
        setState(() {
          _formData['data'].height =
              value == '' ? null : double.tryParse(value);
        });
      },
    );
  }

  Widget _imageWidth() {
    return TextFormField(
      initialValue: _currentItem != null && _currentItem.data['width'] != null
          ? _currentItem.data['width'].toString()
          : null,
      decoration: InputDecoration(
        hintText: Strings.imageWidth,
      ),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      onSaved: (value) {
        setState(() {
          _formData['data'].width = value == '' ? null : double.tryParse(value);
        });
      },
    );
  }
}
