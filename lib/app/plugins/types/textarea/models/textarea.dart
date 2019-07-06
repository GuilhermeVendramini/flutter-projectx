class TextAreaModel {
  String text;

  TextAreaModel({
    this.text,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'text': this.text,
      };

  factory TextAreaModel.fromJson(Map<String, dynamic> json) {
    return TextAreaModel(
      text: json['text'],
    );
  }
}
