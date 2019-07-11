class WebViewModel {
  String url;

  WebViewModel({
    this.url,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
    'url': this.url,
  };

  factory WebViewModel.fromJson(Map<String, dynamic> json) {
    return WebViewModel(
      url: json['url'],
    );
  }
}