part of 'schedule_bloc.dart';

sealed class ScheduleEvent extends Equatable {
  const ScheduleEvent();

  @override
  List<Object> get props => [];
}

class ScheduleGetData extends ScheduleEvent {
  final int from;
  final int until;

  const ScheduleGetData(this.from, this.until);

  @override
  List<Object> get props => [from, until];
}
