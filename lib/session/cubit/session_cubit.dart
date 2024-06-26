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
              type: SessionCubit.listTypes[0],
              nameTrack: '',
              to: TimeOfDay.fromDateTime(DateTime(13, 23)),
              until: TimeOfDay.fromDateTime(DateTime(13, 23)),
              admins: [],
              apiAdmins: []),
        );

  static const List<String> listTypes = ['Запись', 'Сведение', 'Мастеринг'];
  // static const List<String> listAdmins = ['smokeynagato', 'icantluvv', 'Rany'];
  static List<Admin> listAdmins = [];

  Future<void> init() async {
    final session = await Session(
        type: SessionCubit.listTypes[0],
        nameTrack: '',
        to: TimeOfDay.fromDateTime(DateTime(13, 23)),
        until: TimeOfDay.fromDateTime(DateTime(13, 23)),
        admins: [],
        apiAdmins: []).init();

    listAdmins = session.apiAdmins;
    emit(session);
  }

  void updateTime(TimeOfDay? to, TimeOfDay? until) {
    emit(state.copyWith(
      to: to,
      until: until,
    ));
  }

  void updateType(String? value) {
    emit(state.copyWith(type: value));
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
    final data = await CreateSession.call(token: FFAppState().userAuthToken);

    if (data.succeeded) {
      // Provider.of<ScheduleBloc>(context).add(ScheduleGetData());

      ScaffoldMessenger.of(context)
          .showSnackBar(functions.infoSnackBar("Сессия успешно создана"));

      context.pop();
    }
  }
}
