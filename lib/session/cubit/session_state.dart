import 'package:flutter/material.dart';

class Session {
  final Type type;
  final String nameTrack;
  final TimeOfDay to;
  final TimeOfDay until;
  final DateTime day;
  final List<String> admins;

  Session(
      {required this.type,
      required this.nameTrack,
      required this.to,
      required this.until,
      required this.day,
      required this.admins});

  Session copyWith({
    Type? type,
    String? nameTrack,
    TimeOfDay? to,
    TimeOfDay? until,
    DateTime? day,
    List<String>? admins,
    List<Admin>? apiAdmins,
  }) {
    return Session(
        type: type ?? this.type,
        nameTrack: nameTrack ?? this.nameTrack,
        to: to ?? this.to,
        until: until ?? this.until,
        day: day ?? this.day,
        admins: admins ?? this.admins);
  }
}

class Admin {
  final int id;
  final String nickname;

  const Admin({
    required this.id,
    required this.nickname,
  });

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      id: json['id'] as int,
      nickname: json['nickname'] as String,
    );
  }
}

class Type {
  final int id;
  final String name;

  const Type({
    required this.id,
    required this.name,
  });

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
      id: (json['id'] as int) - 1,
      name: json['name'] as String,
    );
  }
}

class Target {
  int key;
  String title;

  Target({required this.key, required this.title});

  factory Target.fromJson(Map<String, dynamic> data) {
    return Target(
      key: data['key'],
      title: data['title'],
    );
  }
}
