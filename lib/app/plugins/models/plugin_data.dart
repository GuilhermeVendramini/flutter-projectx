import 'package:flutter/material.dart';

class PluginDataModel {
  int id;
  String type;
  int parent;
  String value;
  int weight;

  PluginDataModel({
    this.id,
    @required this.type,
    @required this.parent,
    @required this.value,
    @required this.weight,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': this.id,
        'type': this.type,
        'parent': this.parent,
        'value': this.value,
        'weight': this.weight
      };

  factory PluginDataModel.fromJson(Map<String, dynamic> json) {
    return PluginDataModel(
      id: json['id'],
      type: json['type'],
      parent: json['parent'],
      value: json['value'],
      weight: json['weight'],
    );
  }
}
