class ImageFieldModel {
  String image;
  double height;
  double width;

  ImageFieldModel({
    this.image,
    this.height,
    this.width,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'image': this.image,
        'height': this.height,
        'width': this.width,
      };

  factory ImageFieldModel.fromJson(Map<String, dynamic> json) {
    return ImageFieldModel(
      image: json['image'],
      height: json['height'],
      width: json['width'],
    );
  }
}
