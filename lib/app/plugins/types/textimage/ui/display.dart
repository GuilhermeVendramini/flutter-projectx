import 'dart:io';

import 'package:flutter/material.dart';
import 'package:projetcx/app/plugins/types/textimage/models/textimage.dart';

class PluginTextImageFieldDisplay {
  PluginTextImageFieldDisplay._();

  static build(Map<String, dynamic> data) {
    final TextImageModel _data = TextImageModel.fromJson(data);
    final _file = File(_data.image);

    Widget _titleDisplay() {
      return Padding(
        padding: EdgeInsets.only(
          top: 20,
          bottom: 20,
        ),
        child: Text(
          _data.title,
          style: TextStyle(
            fontSize: 40.0,
          ),
        ),
      );
    }

    Widget _contentDisplay() {
      return Padding(
        padding: EdgeInsets.only(
          top: 20,
          bottom: 20,
        ),
        child: Text(
          _data.text,
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      );
    }

    Widget _textColumn() {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _titleDisplay(),
            _contentDisplay(),
          ],
        ),
      );
    }

    Widget _imageColumn() {
      return Container(
        padding: EdgeInsets.all(20.0),
        child: Image(
          image: FileImage(_file),
        ),
      );
    }

    return GridView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      children: <Widget>[
        _textColumn(),
        _imageColumn(),
      ],
    );
  }
}
