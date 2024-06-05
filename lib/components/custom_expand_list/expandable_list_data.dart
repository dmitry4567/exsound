import 'package:flutter/material.dart';
import 'dart:convert';

class Target {
  String key;
  String title;
  String? description;
  List<Target>? nodes;

  Target(
      {required this.key, required this.title, this.description, this.nodes});

  factory Target.fromJson(Map<String, dynamic> data) {
    final nodesData = data['nodes'] as List<dynamic>?;

    // ignore: prefer_null_aware_operators
    final nodes = nodesData != null
        ? nodesData.map((item) => Target.fromJson(item)).toList()
        : null;
    return Target(
        key: data['key'],
        title: data['title'],
        description: data['description'],
        nodes: nodes);
  }
}

List<Target> targetsFromJson(String str) {
  return List<Target>.from(json.decode(str).map((x) => Target.fromJson(x)));
}

class ExpandableListData extends ChangeNotifier {
  List<Target> items = [];
  String? selectedItem;

  void addItems(List<Target> newItems) {
    items = newItems;
    notifyListeners();
  }

  void selectItem(String newSelectItem) {
    selectedItem = newSelectItem;
    notifyListeners();
  }
}
