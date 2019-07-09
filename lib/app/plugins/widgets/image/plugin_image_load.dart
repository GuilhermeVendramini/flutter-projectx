import 'dart:io';

import 'package:flutter/material.dart';

class PluginImageLoad extends StatefulWidget {
  final String image;

  PluginImageLoad({@required this.image});

  @override
  _PluginImageLoadState createState() => _PluginImageLoadState();
}

class _PluginImageLoadState extends State<PluginImageLoad> {
  bool _fileIsLoading = true;
  bool _fileNotExists = false;
  File _file;

  @override
  Widget build(BuildContext context) {
    final Future<bool> _fileExists = File(widget.image).exists();

    if (_fileIsLoading) {
      _fileExists.then((result) {
        if (result) {
          _file = File(widget.image);
          _fileIsLoading = false;
        } else {
          _fileNotExists = true;
          _fileIsLoading = false;
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
