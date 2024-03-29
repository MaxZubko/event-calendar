import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_calendar_app/features/home/home.dart';
import 'package:event_calendar_app/features/home/widgets/calendar_body.dart';
import 'package:event_calendar_app/services/firestore_service/firestore_service.dart';
import 'package:event_calendar_app/services/firestore_service/models/calendar_event_model/calendar_event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              CalendarHeader(),
              Expanded(child: CalendarBody()),
              GestureDetector(
                onTap: () {
                  final service =
                      FirestoreService(db: FirebaseFirestore.instance);
                  service.addEvent(
                    event: CalendarEventModel(
                      title: 'delete element',
                      startTime: DateTime.now(),
                      endTime: DateTime(2024, 9, 4, 12)
                          .add(const Duration(hours: 1)),
                    ),
                    docId: '3838',
                  );
                  // service.getEvents(docId: '3838');
                  // service.deleteEvent(
                  //   event: CalendarEventModel(
                  //     title: 'delete element',
                  //     startTime: DateTime(2024, 4, 4, 12),
                  //     endTime: DateTime(2024, 4, 4, 12)
                  //         .add(const Duration(hours: 1)),
                  //   ),
                  //   docId: '3838',
                  // );
                },
                child: Container(
                  height: 30,
                  width: 60,
                  color: Colors.amber,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
