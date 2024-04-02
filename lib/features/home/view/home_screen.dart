import 'package:event_calendar_app/cubit/calendar_event_cubit.dart';
import 'package:event_calendar_app/features/home/home.dart';
import 'package:event_calendar_app/services/firestore_service/models/calendar_event_model/calendar_event_model.dart';
import 'package:event_calendar_app/ui/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Calendar Event',
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
              SizedBox(height: 20),
              Expanded(flex: 2, child: EventsList()),
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
      eventCubit.addEvent(event: eventModel);
    }
  }
}
