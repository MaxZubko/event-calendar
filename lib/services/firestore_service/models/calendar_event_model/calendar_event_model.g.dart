// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarEventModel _$CalendarEventModelFromJson(Map<String, dynamic> json) =>
    CalendarEventModel(
      title: json['title'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime:
          CalendarEventModel._dateTimeFromFirestore(json['endTime'] as int),
      eventId: json['eventId'] as String,
    );

Map<String, dynamic> _$CalendarEventModelToJson(CalendarEventModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': CalendarEventModel._dateTimeToFirestore(instance.endTime),
      'eventId': instance.eventId,
    };
