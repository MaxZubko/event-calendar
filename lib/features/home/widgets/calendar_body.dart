import 'package:event_calendar_app/cubit/calendar_event_cubit.dart';
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

            return BlocBuilder<CalendarEventCubit, CalendarEventState>(
              builder: (context, eventState) {
                final eventsCubit = context.read<CalendarEventCubit>();

                return SliverPadding(
                  padding: const EdgeInsets.only(top: 20),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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

                        final bool hasEventForDate =
                            eventsCubit.hasEventForDate(
                          dateTime: DateTime(
                            calendarState.currentDate.year,
                            calendarState.currentDate.month,
                            day,
                          ),
                        );

                        return Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
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
                        );
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
