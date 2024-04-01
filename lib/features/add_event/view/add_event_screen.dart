import 'package:event_calendar_app/widgets/widget.dart';
import 'package:flutter/material.dart';

class AddEventScreen extends StatelessWidget {
  const AddEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'Event Details'),
      body: Center(child: Text('Add event')),
    );
  }
}
