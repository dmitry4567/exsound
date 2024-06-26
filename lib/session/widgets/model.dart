import 'package:flutter/material.dart';
import 'dart:convert';

class Target {
  String key;
  String title;

  Target({required this.key, required this.title});

  factory Target.fromJson(Map<String, dynamic> data) {
    return Target(
      key: data['key'],
      title: data['title'],
    );
  }
}

List<Target> targetsFromJson(String str) {
  return List<Target>.from(json.decode(str).map((x) => Target.fromJson(x)));
}

class ExpandableListData extends ChangeNotifier {
  List<Target> itemsType = [
    Target(key: '0', title: 'Запись'),
    Target(key: '1', title: 'Сведение'),
    Target(key: '2', title: 'Мастеринг'),
  ];
  String? _selectedItemType;

  String? get selectedItemType => _selectedItemType;

  set setItemType(String value) {
    _selectedItemType = value;
    notifyListeners();
  }
}
