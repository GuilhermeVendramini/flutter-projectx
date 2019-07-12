import 'package:flutter/material.dart';
import 'package:simpleslider/app/plugins/types/textimage/models/textimage.dart';
import 'package:simpleslider/app/plugins/widgets/image/plugin_image_load.dart';

class PluginTextImageFieldDisplay {
  PluginTextImageFieldDisplay._();

  static build(Map<String, dynamic> data) {
    final TextImageModel _data = TextImageModel.fromJson(data);

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

    return GridView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      children: <Widget>[
        _textColumn(),
        PluginImageLoad(image: _data.image),
      ],
    );
  }
}
