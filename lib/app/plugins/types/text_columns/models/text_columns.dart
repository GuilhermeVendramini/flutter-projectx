class TextColumnsModel {
  String titleOne;
  String textOne;
  String titleTwo;
  String textTwo;

  TextColumnsModel({
    this.titleOne,
    this.textOne,
    this.titleTwo,
    this.textTwo,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'titleOne': this.titleOne,
        'textOne': this.textOne,
        'titleTwo': this.titleTwo,
        'textTwo': this.textTwo,
      };

  factory TextColumnsModel.fromJson(Map<String, dynamic> json) {
    return TextColumnsModel(
      titleOne: json['titleOne'],
      textOne: json['textOne'],
      titleTwo: json['titleTwo'],
      textTwo: json['textTwo'],
    );
  }
}
