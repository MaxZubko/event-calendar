import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event_calendar_app/services/services.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'calendar_event_state.dart';

class CalendarEventCubit extends Cubit<CalendarEventState> {
  CalendarEventCubit(
      {required FirestoreService service,
      required LocalDatabaseService localDb})
      : _service = service,
        _localDb = localDb,
        super(CalendarEventInitial());

  final FirestoreService _service;
  final LocalDatabaseService _localDb;

  Future<void> loadEvenets() async {
    emit(CalendarEventLoading());
    // final String id = const Uuid().v4();
    String? docId = await _localDb.getDocId();

    if (docId == null) {
      final String newDocId = const Uuid().v4();
      await _localDb.saveDocId(id: newDocId);
      docId = newDocId;
    }

    final events = await _service.getEvents(docId: docId);

    emit(CalendarEventLoaded(events: events));
  }
}
