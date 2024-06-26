import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:event_calendar_app/constants/constants.dart' as constants;
import 'package:event_calendar_app/cubit/calendar_event/calendar_event_cubit.dart';
import 'package:event_calendar_app/get_it_initializer.dart';
import 'package:event_calendar_app/services/services.dart';
import 'package:event_calendar_app/ui/widgets/widget.dart';
import 'package:event_calendar_app/utils/utils.dart';

class EventDetailsScreen extends StatelessWidget {
  final CalendarEventModel eventModel;
  const EventDetailsScreen({
    super.key,
    required this.eventModel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final is24HourFormat = MediaQuery.of(context).alwaysUse24HourFormat;
    final formattedStartTime = DateTimeUtils.formatTime(
        is24HourFormat: is24HourFormat, dateTime: eventModel.startTime);
    final formattedEndTime = DateTimeUtils.formatTime(
        is24HourFormat: is24HourFormat, dateTime: eventModel.endTime);
    final timeRange = 'from $formattedStartTime to $formattedEndTime';

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Event Details',
        textStyle: theme.textTheme.headlineMedium,
        iconActionBtn: const Icon(Icons.edit),
        onPressed: () => _showSearchBottomSheet(
          context: context,
          model: eventModel,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                eventModel.title,
                style: theme.textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              _formatDate(eventModel.startTime),
              style: theme.textTheme.bodyMedium,
            ),
            Text(
              timeRange,
              style: theme.textTheme.bodyMedium,
            ),
            const Expanded(
              child: SizedBox(),
            ),
            Align(
              child: TextButton(
                onPressed: () => _deleteEvent(
                  context: context,
                  event: eventModel,
                ),
                child: Text(
                  'Delete Event',
                  style: theme.textTheme.labelMedium
                      ?.copyWith(color: constants.Colors.redSelected),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    String formattedDate = DateFormat('d MMM y').format(date);
    return formattedDate;
  }

  Future<void> _deleteEvent({
    required BuildContext context,
    required CalendarEventModel event,
  }) async {
    final eventsCubit = context.read<CalendarEventCubit>();

    await eventsCubit.deleteEvent(event: event).then(
          (value) => context.pop(),
        );

    await getIt<LocalNotificationService>().cancelNotification(event.notifyId);
  }

  Future<void> _showSearchBottomSheet({
    required BuildContext context,
    required CalendarEventModel model,
  }) async {
    final eventCubit = context.read<CalendarEventCubit>();
    final newModel = await showModalBottomSheet<CalendarEventModel>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.only(top: 50),
        child: EventBottomSheet(
          eventModel: model,
        ),
      ),
    );
    if (newModel != null) {
      await eventCubit.deleteEvent(event: model).then(
            (value) async => await getIt<LocalNotificationService>()
                .cancelNotification(model.notifyId),
          );

      await getIt<LocalNotificationService>().showScheduleNotification(
        title: 'Event',
        body: newModel.title,
        payload: '',
        selectedDate: newModel.startTime,
        id: newModel.notifyId,
      );

      await eventCubit.addEvent(event: newModel).then(
            (value) => context.pop(),
          );
    }
  }
}
