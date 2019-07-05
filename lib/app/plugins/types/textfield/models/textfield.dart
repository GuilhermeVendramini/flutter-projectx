class TextFieldModel {
  String title;

  TextFieldModel({
    this.title,
  });

  Map<String, dynamic> toJson() => <String, dynamic> {
    'title': this.title,
  };

  factory TextFieldModel.fromJson(Map<String, dynamic> json) {
    return TextFieldModel(
      title: json['title'],
    );
  }

}
