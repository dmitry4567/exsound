import 'package:exstudio/backend/api_requests/api_calls.dart';
import 'package:exstudio/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class Session {
  final String type;
  final String nameTrack;
  final TimeOfDay to;
  final TimeOfDay until;
  final DateTime day;
  final List<String> admins;

  List<Admin> apiAdmins;

  Session(
      {required this.type,
      required this.nameTrack,
      required this.to,
      required this.until,
      required this.day,
      required this.admins,
      required this.apiAdmins});

  Future<Session> init() async {
    final data = await GetAdmins.call(token: FFAppState().userAuthToken);

    List<Admin> admins = List<Admin>.from(
        data.jsonBody.map((project) => Admin.fromJson(project)).toList());

    return this.copyWith(apiAdmins: admins);
  }

  Session copyWith({
    String? type,
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
        admins: admins ?? this.admins,
        apiAdmins: apiAdmins ?? this.apiAdmins);
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
