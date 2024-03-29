import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_calendar_app/services/services.dart';

abstract interface class FirestoreServiceInterface {
  CollectionReference getCollection();
  Future<void> addEvent({
    required CalendarEventModel event,
    required String docId,
  });
  Future<List<CalendarEventModel>> getEvents({required String docId});
  Future<void> updateEvent({required String docId});
  Future<void> deleteEvent({
    required CalendarEventModel event,
    required String docId,
  });
}
