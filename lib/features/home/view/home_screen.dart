import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:event_calendar_app/cubit/calendar_event/calendar_event_cubit.dart';
import 'package:event_calendar_app/features/home/home.dart';
import 'package:event_calendar_app/get_it_initializer.dart';
import 'package:event_calendar_app/services/services.dart';
import 'package:event_calendar_app/ui/widgets/widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Calendar Event',
        textStyle: theme.textTheme.headlineMedium,
        iconActionBtn: const Icon(Icons.add),
        onPressed: () => _showSearchBottomSheet(context),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            children: [
              CalendarHeader(),
              SizedBox(height: 20),
              Flexible(child: CalendarBody()),
              Divider(),
              Flexible(child: EventsList()),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showSearchBottomSheet(BuildContext context) async {
    final eventCubit = context.read<CalendarEventCubit>();
    final eventModel = await showModalBottomSheet<CalendarEventModel>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      context: context,
      builder: (context) => const Padding(
        padding: EdgeInsets.only(top: 100),
        child: EventBottomSheet(),
      ),
    );
    if (eventModel != null) {
      await eventCubit.addEvent(event: eventModel);
      await getIt<LocalNotificationService>().showScheduleNotification(
        title: 'Event',
        body: eventModel.title,
        payload: '',
        selectedDate: eventModel.startTime,
        id: eventModel.notifyId,
      );
    }
  }
}
