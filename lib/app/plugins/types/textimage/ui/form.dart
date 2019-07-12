import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simpleslider/app/constants/app_colors.dart';
import 'package:simpleslider/app/constants/strings.dart';
import 'package:simpleslider/app/models/page.dart';
import 'package:simpleslider/app/plugins/controllers/plugins.dart';
import 'package:simpleslider/app/plugins/models/plugin_data.dart';
import 'package:simpleslider/app/plugins/types/textimage/models/textimage.dart';
import 'package:simpleslider/app/widgets/plugins/options_buttons.dart';
import 'package:simpleslider/app/widgets/utils/gradient_background.dart';
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
  bool _currentFileVerified = false;
  Color _pageColor;

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

    _getCurrentFile() {
      _currentFileVerified = true;
      final Future<bool> _fileExists =
          File(_currentItem.data['image']).exists();
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
      child: GradientBackground(
        color: _pageColor,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: _pageColor,
            centerTitle: true,
            title: Text(Strings.addTextImage),
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
          floatingActionButton: _image != null
              ? PluginsFloatingButtons(_parent, _formKey, _formData)
              : PluginsFloatingButtonsDisable(),
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
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _imageButtons(),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20.0),
            child: _image == null ? Text(Strings.noImage) : Image.file(_image),
          ),
        ],
      ),
    );
  }

  Widget _textColumn() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            initialValue:
                _currentItem != null ? _currentItem.data['title'] : null,
            autofocus: true,
            decoration: InputDecoration(
              hintText: Strings.title,
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
            initialValue:
                _currentItem != null ? _currentItem.data['text'] : null,
            keyboardType: TextInputType.multiline,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: Strings.longText,
            ),
            onSaved: (value) {
              setState(() {
                _formData['data'].text = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _imageButtons() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      runAlignment: WrapAlignment.center,
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
    );
  }
}
