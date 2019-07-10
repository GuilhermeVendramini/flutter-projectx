class YoutubeFieldModel {
  String videoId;
  double width;

  YoutubeFieldModel({
    this.videoId,
    this.width,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'videoId': this.videoId,
        'width': this.width,
      };

  factory YoutubeFieldModel.fromJson(Map<String, dynamic> json) {
    return YoutubeFieldModel(
      videoId: json['videoId'],
      width: json['width'],
    );
  }
}
