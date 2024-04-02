import 'package:event_calendar_app/cubit/calendar_event_cubit.dart';
import 'package:event_calendar_app/features/home/cubit/calendar_cubit.dart';
import 'package:event_calendar_app/features/home/widgets/calendar_week_days.dart';
import 'package:event_calendar_app/services/firestore_service/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:event_calendar_app/constants/constants.dart' as constants;

class CalendarBody extends StatefulWidget {
  const CalendarBody({super.key});

  @override
  State<CalendarBody> createState() => _CalendarBodyState();
}

class _CalendarBodyState extends State<CalendarBody> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        const SliverToBoxAdapter(
          child: CalendarWeekDays(),
        ),
        BlocBuilder<CalendarCubit, CalendarState>(
          builder: (context, calendarState) {
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

            return StreamBuilder<List<CalendarEventModel>>(
              stream: context.watch<CalendarEventCubit>().listStream,
              builder: (context, snapshot) {
                final eventsCubit = context.read<CalendarEventCubit>();
                if (snapshot.hasData) {
                  return SliverPadding(
                    padding: const EdgeInsets.only(top: 20),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        crossAxisSpacing: 10,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          final day = index + 1 - firstDayOfWeek;

                          if (day <= 0 || day > daysInMonth) {
                            return Container();
                          }

                          final bool hasEventForDate =
                              eventsCubit.hasEventForDate(
                            dateTime: DateTime(
                              calendarState.currentDate.year,
                              calendarState.currentDate.month,
                              day,
                            ),
                          );

                          final bool isCurrent = checkCurrentDay(
                            now: calendarState.selectedDate,
                            selectedDate: calendarState.currentDate,
                            day: day,
                          );

                          return GestureDetector(
                            onTap: () {
                              final calendarCubit =
                                  context.read<CalendarCubit>();
                              calendarCubit.changeDate(
                                currentDate: calendarState.currentDate,
                                day: day,
                              );
                            },
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  decoration: isCurrent
                                      ? const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: constants.Colors.greenSelected,
                                        )
                                      : null,
                                  child: Text(day.toString()),
                                ),
                                if (hasEventForDate)
                                  Container(
                                    width: 5,
                                    height: 5,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey,
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                        // childCount: daysInMonth + firstDayOfWeek,
                      ),
                    ),
                  );
                } else {
                  return const SliverToBoxAdapter(child: SizedBox());
                }
              },
            );
          },
        ),
      ],
    );
  }

  bool checkCurrentDay({
    required DateTime now,
    required DateTime selectedDate,
    required int day,
  }) {
    return now.year == selectedDate.year &&
        now.month == selectedDate.month &&
        now.day == day;
  }
}
