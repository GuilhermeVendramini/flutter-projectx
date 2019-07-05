import 'package:flutter/material.dart';

class PluginDataModel {
  int id;
  String type;
  int parent;
  String data;
  int weight;

  PluginDataModel({
    this.id,
    @required this.type,
    @required this.parent,
    @required this.data,
    @required this.weight,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': this.id,
        'type': this.type,
        'parent': this.parent,
        'data': this.data,
        'weight': this.weight
      };

  factory PluginDataModel.fromJson(Map<String, dynamic> json) {
    return PluginDataModel(
      id: json['id'],
      type: json['type'],
      parent: json['parent'],
      data: json['data'],
      weight: json['weight'],
    );
  }
}
