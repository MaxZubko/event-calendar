part of 'calendar_event_cubit.dart';

@immutable
sealed class CalendarEventState extends Equatable {
  const CalendarEventState();

  @override
  List<Object> get props => [];
}

final class CalendarEventInitial extends CalendarEventState {}

final class CalendarEventLoading extends CalendarEventState {}

final class CalendarEventLoaded extends CalendarEventState {
  const CalendarEventLoaded({required this.events});

  final List<CalendarEventModel> events;

  @override
  List<Object> get props => [events];
}

final class CalendarEventFailure extends CalendarEventState {
  const CalendarEventFailure({required this.error});

  final Object error;

  @override
  List<Object> get props => [error];
}
