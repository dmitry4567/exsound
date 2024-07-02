import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:exstudio/backend/api_requests/api_calls.dart';
import 'package:exstudio/flutter_flow/flutter_flow_util.dart';
import 'package:exstudio/session/cubit/session_state.dart';
import 'package:flutter/material.dart';
import 'package:exstudio/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter_bloc/flutter_bloc.dart';

class SessionCubit extends Cubit<Session> {
  SessionCubit()
      : super(
          Session(
              type: Type(id: 0, name: ''),
              nameTrack: '',
              to: TimeOfDay.fromDateTime(DateTime(13, 23)),
              until: TimeOfDay.fromDateTime(DateTime(13, 23)),
              day: DateTime.now(),
              admins: []),
        );

  // static const List<String> listTypes = ['Запись', 'Сведение', 'Мастеринг'];
  // static const List<String> listAdmins = ['smokeynagato', 'icantluvv', 'Rany'];
  static List<Type> listTypes = [];
  static List<Admin> listAdmins = [];

  Future<dynamic> init() async {
    // final session = await Session(
    //     type: SessionCubit.listTypes[0],
    //     nameTrack: '',
    //     to: TimeOfDay.fromDateTime(DateTime(13, 23)),
    //     until: TimeOfDay.fromDateTime(DateTime(13, 23)),
    //     day: DateTime.now(),
    //     admins: [],
    //     apiAdmins: []).init();

    // if (session.)
    final data = await Future.wait([
      GetTypes.call(token: FFAppState().userAuthToken),
      GetAdmins.call(token: FFAppState().userAuthToken)
    ]);

    if (data[0].succeeded && data[1].succeeded) {
      List<Type> types = List<Type>.from(
          data[0].jsonBody.map((project) => Type.fromJson(project)).toList());
      List<Admin> admins = List<Admin>.from(
          data[1].jsonBody.map((project) => Admin.fromJson(project)).toList());

      listTypes = types;
      listAdmins = admins;
    }
  }

  void updateDay(DateTime day) {
    emit(state.copyWith(day: day));
  }

  void updateTime(TimeOfDay? to, TimeOfDay? until) {
    emit(state.copyWith(
      to: to,
      until: until,
    ));
  }

  void updateType(int? key) {
    emit(state.copyWith(type: listTypes.firstWhere((type) => type.id== key)));
  }

  void updateNameTrack(String? value) {
    emit(state.copyWith(nameTrack: value));
  }

  void updateAdmins(String value) {
    List<String> admins = List.from(state.admins);

    if (!admins.any((admin) => admin == value)) {
      admins.add(value);
    } else {
      admins.remove(value);
    }

    emit(state.copyWith(admins: admins));
  }

  void createSession(BuildContext context) async {
    final dateTo = DateTime(
      this.state.day.year,
      this.state.day.month,
      this.state.day.day,
      this.state.to.hour,
      this.state.to.minute,
    ).millisecondsSinceEpoch;

    final dateUntil = DateTime(
      this.state.day.year,
      this.state.day.month,
      this.state.day.day,
      this.state.until.hour,
      this.state.until.minute,
    ).millisecondsSinceEpoch;

    final data = await CreateSession.call(
      token: FFAppState().userAuthToken,
      type: this.state.type.id + 1,
      name: this.state.nameTrack,
      to: dateTo,
      until: dateUntil,
    );

    if (data.succeeded) {
      ScaffoldMessenger.of(context)
          .showSnackBar(functions.infoSnackBar("Сессия успешно создана"));

      context.pop();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(functions.setupSnackBar(data.jsonBody['message']));
    }
  }
}
