class DeviceMediaQuery {
  DeviceMediaQuery._();

  static double getTargetWidth(double width) {
    final double deviceWidth = width;
    final double targetWidth = deviceWidth > 650.0 ? 600.0 : deviceWidth * 0.95;
    return targetWidth;
  }
}
