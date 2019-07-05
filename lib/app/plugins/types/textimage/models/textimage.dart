class TextImageModel {
  String title;
  String content;
  String image;

  TextImageModel({
    this.title,
    this.content,
    this.image,
  });

  Map<String, dynamic> toJson() => <String, dynamic> {
        'title': this.title,
        'content': this.content,
        'image': this.image
      };

  factory TextImageModel.fromJson(Map<String, dynamic> json) {
    return TextImageModel(
      title: json['title'],
      content: json['content'],
      image: json['image'],
    );
  }
}
