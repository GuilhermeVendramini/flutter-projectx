class TextImageModel {
  String title;
  String text;
  String image;

  TextImageModel({
    this.title,
    this.text,
    this.image,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': this.title,
        'text': this.text,
        'image': this.image
      };

  factory TextImageModel.fromJson(Map<String, dynamic> json) {
    return TextImageModel(
      title: json['title'],
      text: json['text'],
      image: json['image'],
    );
  }
}
