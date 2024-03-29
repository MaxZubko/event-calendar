import 'package:event_calendar_app/features/home/cubit/calendar_cubit.dart';
import 'package:event_calendar_app/features/home/widgets/calendar_week_days.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarBody extends StatefulWidget {
  const CalendarBody({super.key});

  @override
  State<CalendarBody> createState() => _CalendarBodyState();
}

class _CalendarBodyState extends State<CalendarBody> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: CalendarWeekDays(),
        ),
        Builder(
          builder: (context) {
            final calendarState = context.watch<CalendarCubit>().state;
            final daysInMonth = DateTime(calendarState.currentDate.year,
                    calendarState.currentDate.month + 1, 0)
                .day;
            int firstDayOfWeek = DateTime(calendarState.currentDate.year,
                    calendarState.currentDate.month, 0)
                .weekday;

            // so that the first line with dates is not empty
            if (firstDayOfWeek > 6) {
              firstDayOfWeek = 0;
            }

            return SliverPadding(
              padding: const EdgeInsets.only(top: 20),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final day = index + 1 - firstDayOfWeek;

                    if (day <= 0 || day > daysInMonth) {
                      return Container();
                    }

                    return Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Text(day.toString()),
                        ),
                        // Container(
                        //   width: 10,
                        //   height: 10,
                        //   alignment: Alignment.center,
                        //   padding: const EdgeInsets.symmetric(vertical: 8),
                        //   decoration: const BoxDecoration(
                        //     shape: BoxShape.circle,
                        //     color: Colors.red, // Цвет кружка
                        //   ),
                        //   child: Text(day.toString()),
                        // ),
                      ],
                    );
                  },
                  // childCount: daysInMonth + firstDayOfWeek,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
