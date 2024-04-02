import 'package:event_calendar_app/cubit/calendar_event_cubit.dart';
import 'package:event_calendar_app/features/home/cubit/calendar_cubit.dart';
import 'package:event_calendar_app/router/app_route_name_constants.dart';
import 'package:event_calendar_app/services/firestore_service/models/models.dart';
import 'package:event_calendar_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EventsList extends StatelessWidget {
  const EventsList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: Divider(),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 15),
        ),
        BlocSelector<CalendarCubit, CalendarState, DateTime>(
          selector: (state) => state.selectedDate,
          builder: (context, selectedDate) {
            return StreamBuilder<List<CalendarEventModel>>(
              stream: context.watch<CalendarEventCubit>().listStream,
              builder: (context, snapshot) {
                final eventsCubit = context.read<CalendarEventCubit>();
                final List<CalendarEventModel> eventsList =
                    eventsCubit.getEventsByDate(date: selectedDate);

                if (eventsList.isNotEmpty) {
                  return SliverList.separated(
                    itemCount: eventsList.length,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 15,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => context.pushNamed(
                          AppRouteNameConstants.eventDetailsRoutePath,
                          extra: eventsList[index],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  DateTimeUtils.formatTime(
                                    context,
                                    eventsList[index].startTime,
                                  ),
                                  style: theme.textTheme.bodyMedium,
                                ),
                                const Text(' - '),
                                Text(
                                  DateTimeUtils.formatTime(
                                      context, eventsList[index].endTime),
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            Text(
                              eventsList[index].title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleMedium,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text('No Events'),
                    ),
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }
}
