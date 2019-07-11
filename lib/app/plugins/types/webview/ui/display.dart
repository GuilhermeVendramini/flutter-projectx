import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:projetcx/app/plugins/types/webview/models/webview.dart';

class PluginWebViewDisplay {
  PluginWebViewDisplay._();

  static build(Map<String, dynamic> data) {
    final WebViewModel _data = WebViewModel.fromJson(data);
    return WebViewApp(data: _data);
  }
}

class WebViewApp extends StatefulWidget {
  final WebViewModel data;

  WebViewApp({@required this.data});

  @override
  _WebViewAppState createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  final Color color = Colors.white;

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.start,
      children: <Widget>[
        FlatButton.icon(
          padding: EdgeInsets.all(0.0),
          icon: Icon(
            Icons.open_in_new,
            color: color,
          ),
          label: Text(
            widget.data.url,
            style: TextStyle(color: color),
          ),
          onPressed: () {
            _openInWebView(widget.data.url);
          },
        ),
      ],
    );
  }

  _openInWebView(String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebviewScaffold(
          url: widget.data.url,
          appBar: AppBar(
            title: Text(widget.data.url),
          ),
        ),
      ),
    );
  }
}
