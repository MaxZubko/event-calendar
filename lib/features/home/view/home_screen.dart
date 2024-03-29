import 'package:event_calendar_app/features/home/home.dart';
import 'package:event_calendar_app/features/home/widgets/calendar_body.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              CalendarHeader(),
              Expanded(child: CalendarBody()),
            ],
          ),
        ),
      ),
    );
  }
}
