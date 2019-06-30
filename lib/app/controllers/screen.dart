import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScreenController with ChangeNotifier {
  bool _isFullScreen = false;
}

class Screen extends ScreenController {
  get isFullScreen {
    return _isFullScreen;
  }
}

class ScreenService extends Screen {
  void setFullScreen(bool fullScreen) {
    if (fullScreen) {
      SystemChrome.setEnabledSystemUIOverlays([]);
      _isFullScreen = true;
      notifyListeners();
    } else {
      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
      _isFullScreen = false;
      notifyListeners();
    }
  }
}
