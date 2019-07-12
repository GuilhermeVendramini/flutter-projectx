import 'package:flutter/material.dart';
import 'package:projetcx/app/plugins/types/text_columns/models/text_columns.dart';

class PluginTextColumnsFieldDisplay {
  PluginTextColumnsFieldDisplay._();

  static build(Map<String, dynamic> data) {
    final TextColumnsModel _data = TextColumnsModel.fromJson(data);

    Widget _titleOne() {
      return Padding(
        padding: EdgeInsets.only(
          top: 20,
          bottom: 20,
        ),
        child: Text(
          _data.titleOne,
          style: TextStyle(
            fontSize: 40.0,
          ),
        ),
      );
    }

    Widget _textOne() {
      return Padding(
        padding: EdgeInsets.only(
          top: 20,
          bottom: 20,
        ),
        child: Text(
          _data.textOne,
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      );
    }

    Widget _columnOne() {
      return SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _titleOne(),
            _textOne(),
          ],
        ),
      );
    }

    Widget _titleTwo() {
      return Padding(
        padding: EdgeInsets.only(
          top: 20,
          bottom: 20,
        ),
        child: Text(
          _data.titleTwo,
          style: TextStyle(
            fontSize: 40.0,
          ),
        ),
      );
    }

    Widget _textTwo() {
      return Padding(
        padding: EdgeInsets.only(
          top: 20,
          bottom: 20,
        ),
        child: Text(
          _data.textTwo,
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      );
    }

    Widget _columnTwo() {
      return SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _titleTwo(),
            _textTwo(),
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
        _columnOne(),
        _columnTwo(),
      ],
    );
  }
}
