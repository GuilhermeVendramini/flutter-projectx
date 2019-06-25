import 'package:flutter/material.dart';

class PageModel {
  final int id;
  String name;
  int color;
  int weight;

  PageModel({
    this.id,
    @required this.name,
    @required this.color,
    @required this.weight,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': this.id,
        'name': this.name,
        'color': this.color,
        'weight': this.weight
      };

  factory PageModel.fromJson(Map<String, dynamic> json) {
    return PageModel(
      id: json['id'],
      name: json['name'],
      color: json['color'],
      weight: json['weight'],
    );
  }
}
