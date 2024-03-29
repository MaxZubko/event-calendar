import 'package:bloc/bloc.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit() : super(CalendarState(DateTime.now()));

  void nextMonth() {
    final nextMonthDate =
        DateTime(state.currentDate.year, state.currentDate.month + 1);
    emit(CalendarState(nextMonthDate));
  }

  void previousMonth() {
    final previousMonthDate =
        DateTime(state.currentDate.year, state.currentDate.month - 1);
    emit(CalendarState(previousMonthDate));
  }
}
