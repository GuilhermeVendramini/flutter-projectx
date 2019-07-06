class ImageFieldModel {
  String image;

  ImageFieldModel({
    this.image,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'image': this.image,
      };

  factory ImageFieldModel.fromJson(Map<String, dynamic> json) {
    return ImageFieldModel(
      image: json['image'],
    );
  }
}
