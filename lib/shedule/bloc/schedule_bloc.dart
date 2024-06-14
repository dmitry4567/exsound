import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exstudio/backend/api_requests/api_calls.dart';
import 'package:exstudio/shedule/model/studio_session_model.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc() : super(ScheduleInitial()) {
    on<ScheduleGetData>((event, emit) async {
      emit(const ScheduleGettingData());
      ApiCallResponse data = await GetSessionsByTimePeriod.call(
        from: event.from,
        until: event.until,
      );

      if (data.succeeded) {
        if (data.jsonBody.isEmpty) {
          emit(ScheduleDataEmpty());
        } else {
          List<StudioSessions> sessions = List<StudioSessions>.from(data
              .jsonBody
              .map((project) => StudioSessions.fromJson(project))
              .toList());
          emit(ScheduleDataPass(sessions));
        }
      } else {
        emit(ScheduleError("error"));
      }
    });
  }
}
