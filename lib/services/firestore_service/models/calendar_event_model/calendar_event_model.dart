import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'calendar_event_model.g.dart';

@JsonSerializable()
class CalendarEventModel extends Equatable {
  final String title;

  final DateTime startTime;

  @JsonKey(
    toJson: _dateTimeToFirestore,
    fromJson: _dateTimeFromFirestore,
  )
  final DateTime endTime;

  final String eventId;

  final int notifyId;

  const CalendarEventModel({
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.eventId,
    required this.notifyId,
  });

  factory CalendarEventModel.fromFirestore(Map<String, dynamic> json) =>
      _$CalendarEventModelFromJson(json);

  Map<String, dynamic> toFirestore() => _$CalendarEventModelToJson(this);

  static DateTime _dateTimeFromFirestore(int timestamp) =>
      DateTime.fromMillisecondsSinceEpoch(timestamp);

  static int _dateTimeToFirestore(DateTime dateTime) =>
      dateTime.millisecondsSinceEpoch;

  @override
  List<Object?> get props => [title, startTime, endTime, eventId, notifyId];
}
