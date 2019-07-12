import 'package:flutter/material.dart';
import 'package:simpleslider/app/plugins/types/youtubefield/models/youtubefield.dart';
// import 'package:youtube_player/youtube_player.dart';

class PluginYoutubeFieldDisplay {
  PluginYoutubeFieldDisplay._();

  static build(Map<String, dynamic> data) {
    final YoutubeFieldModel _data = YoutubeFieldModel.fromJson(data);

    return YoutubeApp(data: _data);
  }
}

class YoutubeApp extends StatefulWidget {
  final YoutubeFieldModel data;

  YoutubeApp({@required this.data});

  @override
  _YoutubeAppState createState() => _YoutubeAppState();
}

class _YoutubeAppState extends State<YoutubeApp> {
  @override
  Widget build(BuildContext context) {
    return null;
/*    return YoutubePlayer(
      context: context,
      source: widget.data.videoId,
      quality: YoutubeQuality.MEDIUM,
      autoPlay: false,
      loop: false,
      width: widget.data.width,
      reactToOrientationChange: false,
      startFullScreen: false,
      controlsActiveBackgroundOverlay: false,
      controlsTimeOut: Duration(seconds: 4),
      playerMode: YoutubePlayerMode.DEFAULT,
    );*/
  }
}
