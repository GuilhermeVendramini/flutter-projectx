import 'package:projetcx/app/plugins/types/imagefield/models/imagefield.dart';
import 'package:projetcx/app/plugins/widgets/image/plugin_image_load.dart';

class PluginImageFieldDisplay {
  PluginImageFieldDisplay._();

  static build(Map<String, dynamic> data) {
    final ImageFieldModel _data = ImageFieldModel.fromJson(data);
    return PluginImageLoad(
      image: _data.image,
      height: _data.height,
      width: _data.width,
    );
  }
}
