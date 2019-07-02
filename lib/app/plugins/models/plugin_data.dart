import 'package:flutter/material.dart';
import 'package:projetcx/app/plugins/models/plugin.dart';

class PluginDataModel {
  int id;
  int parent;
  String value;
  int weight;

  PluginDataModel({
    this.id,
    @required this.parent,
    @required this.value,
    @required this.weight,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': this.id,
        'parent': this.parent,
        'value': this.value,
        'weight': this.weight
      };

  factory PluginDataModel.fromJson(Map<String, dynamic> json) {
    return PluginDataModel(
      id: json['id'],
      parent: json['parent'],
      value: json['value'],
      weight: json['weight'],
    );
  }
}
