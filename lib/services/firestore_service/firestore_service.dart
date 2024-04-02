import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_calendar_app/constants/constants.dart';
import 'package:event_calendar_app/services/services.dart';

class FirestoreService implements FirestoreServiceInterface {
  final FirebaseFirestore _db;

  FirestoreService({
    required FirebaseFirestore db,
  }) : _db = db;

  @override
  CollectionReference getCollection() {
    return _db.collection(FIREBSTORE_COLLECTION);
  }

  @override
  Future<void> deleteEvent({
    required CalendarEventModel event,
    required String docId,
  }) async {
    final data = {
      'events': FieldValue.arrayRemove(
        [event.toFirestore()],
      ),
    };

    await getCollection().doc(docId).update(data);
  }

  @override
  Future<List<CalendarEventModel>> getEvents({required String docId}) async {
    if (await _checkIfDocExists(docId)) {
      final DocumentSnapshot snapshot = await getCollection().doc(docId).get();
      final List<dynamic> events = snapshot['events'];

      final List<CalendarEventModel> eventsList =
          events.map((json) => CalendarEventModel.fromFirestore(json)).toList();

      return eventsList;
    } else {
      await getCollection().doc(docId).set({'events': []});

      return [];
    }
  }

  @override
  Future<void> addEvent({
    required CalendarEventModel event,
    required String docId,
  }) async {
    final data = {
      'events': FieldValue.arrayUnion([event.toFirestore()])
    };

    await getCollection().doc(docId).update(data);
  }

  Future<bool> _checkIfDocExists(String docId) async {
    try {
      var doc = await getCollection().doc(docId).get();
      return doc.exists;
    } catch (e) {
      rethrow;
    }
  }
}
