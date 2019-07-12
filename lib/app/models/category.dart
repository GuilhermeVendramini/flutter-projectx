import 'package:flutter/material.dart';

class CategoryModel {
  int id;
  String name;
  int color;
  int icon;

  CategoryModel({
    this.id,
    @required this.name,
    @required this.color,
    @required this.icon,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': this.id,
    'name': this.name,
    'color': this.color,
    'icon': this.icon
  };

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      color: json['color'],
      icon: json['icon'],
    );
  }
}
