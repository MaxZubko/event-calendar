import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_calendar_app/constants/constants.dart';
import 'package:event_calendar_app/services/firestore_service/firestore_service.dart';
import 'package:event_calendar_app/services/firestore_service/models/calendar_event_model/calendar_event_model.dart';
import 'package:event_calendar_app/utils/utils.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:collection/collection.dart';

void main() {
  group('DateTimeUtils ', () {
    //Arrange
    final DateTime date = DateTime(2024, 4, 4, 13, 25);

    test('Extract time from DateTime in 24h format HH:mm', () {
      //Act
      final formattedTime =
          DateTimeUtils.formatTime(is24HourFormat: true, dateTime: date);

      //Assert
      expect(formattedTime, '13:25');
    });

    test('Extract time from DateTime in 12 hour format h:mm a', () {
      //Act
      final formattedTime =
          DateTimeUtils.formatTime(is24HourFormat: false, dateTime: date);

      //Assert
      expect(formattedTime, '1:25 PM');
    });
  });

  group('FirestoreService', () {
    FakeFirebaseFirestore? fakeFirebaseFirestore;

    const String collectionPath = FIREBSTORE_COLLECTION;
    const String docId = 'docId';

    const title = 'test';
    final startTime = DateTime(2024, 4, 4, 13, 31);
    final endTime = DateTime(2024, 4, 4, 15, 31);
    const eventId = '34ep-5';
    const notifyId = 1313;

    List<CalendarEventModel> data = [
      CalendarEventModel(
        title: title,
        startTime: startTime,
        endTime: endTime,
        eventId: eventId,
        notifyId: notifyId,
      ),
    ];

    setUp(
      () async {
        fakeFirebaseFirestore = FakeFirebaseFirestore();

        // create an empty document with which we will work in the future
        await fakeFirebaseFirestore!
            .collection(collectionPath)
            .doc(docId)
            .set({'events': []});
      },
    );

    test('Add event', () async {
      final FirestoreService firestoreService =
          FirestoreService(db: fakeFirebaseFirestore!);

      await firestoreService.addEvent(event: data.first, docId: docId);

      final DocumentSnapshot snapshot = await fakeFirebaseFirestore!
          .collection(collectionPath)
          .doc(docId)
          .get();
      final List<dynamic> events = snapshot['events'];
      final List<CalendarEventModel> actualList =
          events.map((json) => CalendarEventModel.fromFirestore(json)).toList();

      bool areEqual = const IterableEquality().equals(actualList, data);

      expect(areEqual, true);
    });

    test('Delete event', () async {
      final FirestoreService firestoreService =
          FirestoreService(db: fakeFirebaseFirestore!);

      await firestoreService.addEvent(event: data.first, docId: docId);

      await firestoreService.deleteEvent(event: data.first, docId: docId);

      final DocumentSnapshot snapshot = await fakeFirebaseFirestore!
          .collection(collectionPath)
          .doc(docId)
          .get();

      final List<dynamic> events = snapshot['events'];
      final List<CalendarEventModel> actualList =
          events.map((json) => CalendarEventModel.fromFirestore(json)).toList();

      bool areEqual = const IterableEquality().equals(actualList, []);

      expect(areEqual, true);
    });
  });
}
