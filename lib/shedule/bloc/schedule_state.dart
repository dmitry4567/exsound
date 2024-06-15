part of 'schedule_bloc.dart';

sealed class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object> get props => [];
}

final class ScheduleInitial extends ScheduleState {
  const ScheduleInitial();
}

final class ScheduleGettingData extends ScheduleState {
  const ScheduleGettingData();
}

final class ScheduleDataPass extends ScheduleState {
  final List<StudioSessions> data;

  const ScheduleDataPass(this.data);

  @override
  List<Object> get props => [data];
}

final class ScheduleDataEmpty extends ScheduleState {
  const ScheduleDataEmpty();
}

final class ScheduleError extends ScheduleState {
  final String error;

  const ScheduleError(this.error);

  @override
  List<Object> get props => [error];
}
