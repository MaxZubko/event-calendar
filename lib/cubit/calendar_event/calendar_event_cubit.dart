import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event_calendar_app/repositories/doc_id_repository/doc_id.dart';
import 'package:event_calendar_app/services/services.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'calendar_event_state.dart';

class CalendarEventCubit extends Cubit<CalendarEventState> {
  CalendarEventCubit(
      {required FirestoreService service, required DocIdRepository localDb})
      : _service = service,
        _localDb = localDb,
        super(CalendarEventInitial()) {
    loadEvents();
  }

  final FirestoreService _service;
  final DocIdRepository _localDb;

  final _controller = StreamController<List<CalendarEventModel>>.broadcast();
  Stream<List<CalendarEventModel>> get listStream => _controller.stream;

  List<CalendarEventModel> _events = [];
  String? _docId;

  Future<void> loadEvents() async {
    try {
      emit(CalendarEventLoading());
      _docId = await _localDb.getDocId();

      _docId ??= await _getDocId();

      _events = await _service.getEvents(docId: _docId!);
      _controller.add(_events);

      // emit(CalendarEventLoaded(events: _events));
    } catch (e) {
      emit(CalendarEventFailure(error: e));
    }
  }

  Future<void> addEvent({required CalendarEventModel event}) async {
    try {
      _docId ??= await _getDocId();

      await _service.addEvent(event: event, docId: _docId!);
      _events.add(event);

      _controller.add(_events);
      // emit(CalendarEventLoaded(events: List.of(_events)));
    } catch (e) {
      emit(CalendarEventFailure(error: e));
    }
  }

  Future<void> deleteEvent({required CalendarEventModel event}) async {
    try {
      _docId ??= await _getDocId();

      await _service.deleteEvent(event: event, docId: _docId!);

      _events.removeWhere((element) => element.eventId == event.eventId);

      _controller.add(_events);
      // emit(CalendarEventLoaded(events: List.of(_events)));
    } catch (e) {
      emit(CalendarEventFailure(error: e));
    }
  }

  List<CalendarEventModel> getEventsByDate({required DateTime date}) {
    List<CalendarEventModel> filteredEvents = _events
        .where(
          (event) =>
              event.startTime.year == date.year &&
              event.startTime.month == date.month &&
              event.startTime.day == date.day,
        )
        .toList();
    return filteredEvents;
  }

  Future<String> _getDocId() async {
    final String newDocId = const Uuid().v4();
    await _localDb.saveDocId(id: newDocId);
    return newDocId;
  }

  bool hasEventForDate({required DateTime dateTime}) {
    return _events.any(
      (event) =>
          event.startTime.year == dateTime.year &&
          event.startTime.month == dateTime.month &&
          event.startTime.day == dateTime.day,
    );
  }

  @override
  Future<void> close() {
    _controller.close();
    return super.close();
  }
}
