import 'dart:io';

import 'package:flutter/material.dart';

class PluginImageLoad extends StatefulWidget {
  final String _image;

  PluginImageLoad(this._image);

  @override
  _PluginImageLoadState createState() => _PluginImageLoadState();
}

class _PluginImageLoadState extends State<PluginImageLoad> {
  bool _fileIsLoading = true;
  bool _fileNotExists = false;
  File _file;

  @override
  Widget build(BuildContext context) {
    final Future<bool> _fileExists = File(widget._image).exists();

    if (_fileIsLoading) {
      _fileExists.then((result) {
        if (result) {
          _file = File(widget._image);
        } else {
          _fileNotExists = true;
        }
        setState(() {
          _fileIsLoading = false;
        });
      });
    }

    if (_fileIsLoading) {
      return Container(
        padding: EdgeInsets.all(20.0),
        child: CircularProgressIndicator(),
      );
    }

    return Container(
      padding: EdgeInsets.all(20.0),
      child: _fileNotExists
          ? Icon(
              Icons.broken_image,
              color: Colors.white,
            )
          : Image(
              image: FileImage(_file),
            ),
    );
  }
}
