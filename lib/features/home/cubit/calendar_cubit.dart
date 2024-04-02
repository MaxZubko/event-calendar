import 'package:bloc/bloc.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit() : super(CalendarState(DateTime.now(), DateTime.now()));

  DateTime _selectedDate = DateTime.now();

  void nextMonth() {
    final nextMonthDate =
        DateTime(state.currentDate.year, state.currentDate.month + 1);
    emit(CalendarState(nextMonthDate, _selectedDate));
  }

  void previousMonth() {
    final previousMonthDate =
        DateTime(state.currentDate.year, state.currentDate.month - 1);
    emit(CalendarState(previousMonthDate, _selectedDate));
  }

  void changeDate({
    required DateTime currentDate,
    required int day,
  }) {
    _selectedDate = DateTime(currentDate.year, currentDate.month, day);
    emit(CalendarState(currentDate, _selectedDate));
  }
}
