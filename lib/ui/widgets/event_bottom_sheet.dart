import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import 'package:event_calendar_app/constants/constants.dart' as constants;
import 'package:event_calendar_app/features/home/cubit/calendar_cubit.dart';
import 'package:event_calendar_app/services/firestore_service/models/calendar_event_model/calendar_event_model.dart';
import 'package:event_calendar_app/ui/widgets/widget.dart';
import 'package:event_calendar_app/utils/utils.dart';

class EventBottomSheet extends StatefulWidget {
  final CalendarEventModel? eventModel;
  const EventBottomSheet({super.key, this.eventModel});

  @override
  State<EventBottomSheet> createState() => _EventBottomSheetState();
}

class _EventBottomSheetState extends State<EventBottomSheet> {
  final TextEditingController _controller = TextEditingController();
  late DateTime _now;

  String? _title;
  DateTime? _startDate;
  TimeOfDay? _startTime;
  DateTime? _endDate;
  TimeOfDay? _endTime;
  String? _eventId;

  late bool _isIos;

  @override
  void initState() {
    _initializeValues();
    _now = context.read<CalendarCubit>().state.selectedDate;
    _isIos = Platform.isIOS;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: const BoxDecoration(
        color: constants.Colors.dark,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            _appBar(theme),
            _sliverGap(15),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: constants.Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: _controller..text = _title ?? '',
                    style: const TextStyle(color: constants.Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Title',
                      hintStyle: TextStyle(
                          color: constants.Colors.grey.withOpacity(0.5)),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (title) {
                      _title = title;
                    },
                  ),
                ),
              ),
            ),
            _sliverGap(25),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                    color: constants.Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      DateTimeSectionBottomSheet(
                        title: 'Starts',
                        initDate: _formatTime(_startDate, _startTime, _now),
                        initTime: _startTime ?? TimeOfDay.fromDateTime(_now),
                        onTapFirestBtn: () async {
                          if (_isIos) {
                            await PickerUtils.showCupertinoSheet(
                                context: context,
                                child: buildCupertinoPicker(
                                  mode: CupertinoDatePickerMode.date,
                                  initialDateTime: _startDate ?? _now,
                                ),
                                onClicked: () {
                                  context.pop();
                                });
                          } else {
                            final startDate =
                                await PickerUtils.showMaterialDateSheet(
                              context: context,
                              initialDate: _startDate ?? _now,
                              firstDate: DateTime(2000, 1),
                              lastDate: DateTime(2100, 12),
                            );

                            setState(() {
                              _startDate = startDate ?? _now;
                            });
                          }
                        },
                        onTapSecondBtn: () async {
                          if (_isIos) {
                            await PickerUtils.showCupertinoSheet(
                              context: context,
                              child: buildCupertinoPicker(
                                mode: CupertinoDatePickerMode.time,
                                initialDateTime:
                                    _formatTime(_startDate, _startTime, _now),
                              ),
                              onClicked: () {
                                context.pop();
                              },
                            );
                          } else {
                            final startTime =
                                await PickerUtils.showMaterialTimeSheet(
                              context: context,
                              initialTime:
                                  _startTime ?? TimeOfDay.fromDateTime(_now),
                            );

                            setState(() {
                              _startTime =
                                  startTime ?? TimeOfDay.fromDateTime(_now);
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 15),
                      DateTimeSectionBottomSheet(
                        title: 'Ends',
                        initDate: _formatTime(_endDate, _endTime, _now),
                        initTime: _endTime ??
                            TimeOfDay.fromDateTime(
                              _now.add(
                                const Duration(hours: 1),
                              ),
                            ),
                        onTapFirestBtn: () async {
                          if (_isIos) {
                            await PickerUtils.showCupertinoSheet(
                                context: context,
                                child: buildCupertinoPicker(
                                  mode: CupertinoDatePickerMode.date,
                                  isStarts: false,
                                  initialDateTime:
                                      _formatTime(_endDate, _endTime, _now),
                                ),
                                onClicked: () {
                                  context.pop();
                                });
                          } else {
                            final endDate =
                                await PickerUtils.showMaterialDateSheet(
                              context: context,
                              initialDate: _endDate ?? _now,
                              firstDate: DateTime(2000, 1),
                              lastDate: DateTime(2100, 12),
                            );
                            setState(() {
                              _endDate = endDate;
                            });
                          }
                        },
                        onTapSecondBtn: () async {
                          if (_isIos) {
                            await PickerUtils.showCupertinoSheet(
                              context: context,
                              child: buildCupertinoPicker(
                                mode: CupertinoDatePickerMode.time,
                                isStarts: false,
                                initialDateTime: _endDate ?? _now,
                              ),
                              onClicked: () {
                                context.pop();
                              },
                            );
                          } else {
                            final endTime =
                                await PickerUtils.showMaterialTimeSheet(
                              context: context,
                              initialTime:
                                  _endTime ?? TimeOfDay.fromDateTime(_now),
                            );

                            setState(() {
                              _endTime = endTime;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _appBar(ThemeData theme) {
    return SliverAppBar(
      pinned: true,
      centerTitle: true,
      leadingWidth: 90,
      leading: TextButton(
        onPressed: () {
          context.pop();
        },
        child: Text(
          'Cancel',
          style: theme.textTheme.titleSmall,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            _onTapEvent(context);
          },
          child: Text(
            'Add',
            style: theme.textTheme.titleSmall,
          ),
        ),
      ],
      title: Text(
        'New Event',
        style: theme.textTheme.titleLarge,
      ),
      elevation: 0,
      surfaceTintColor: Colors.transparent,
    );
  }

  void _initializeValues() {
    if (widget.eventModel != null) {
      CalendarEventModel model = widget.eventModel!;
      _title = model.title;
      _startDate = model.startTime;
      _startTime = TimeOfDay.fromDateTime(model.startTime);
      _endDate = model.endTime;
      _endTime = TimeOfDay.fromDateTime(model.endTime);
      _eventId = model.eventId;
    }
  }

  Widget _sliverGap(double height) => SliverToBoxAdapter(
        child: SizedBox(
          height: height,
        ),
      );

  void _onTapEvent(BuildContext context) {
    context.pop(
      CalendarEventModel(
        title: _title ?? 'New Event',
        startTime: _formatTime(_startDate, _startTime, _now),
        endTime: _formatTime(
          _endDate,
          _endTime,
          _now.add(
            const Duration(hours: 1),
          ),
        ),
        eventId: _eventId ?? const Uuid().v4(),
        notifyId: NotifyUtils().creatingIdForNotify(
          timestamp:
              _formatTime(_startDate, _startTime, _now).millisecondsSinceEpoch,
        ),
      ),
    );
  }

  DateTime _formatTime(DateTime? date, TimeOfDay? time, DateTime now) {
    final _date = date ?? now;
    final _time = time ?? TimeOfDay.fromDateTime(now);
    final DateTime formattedTime =
        DateTime(_date.year, _date.month, _date.day, _time.hour, _time.minute);

    return formattedTime;
  }

  Widget buildCupertinoPicker({
    required CupertinoDatePickerMode mode,
    bool isStarts = true,
    DateTime? initialDateTime,
  }) =>
      SizedBox(
        height: 180,
        child: CupertinoDatePicker(
          initialDateTime: initialDateTime,
          mode: mode,
          use24hFormat: true,
          onDateTimeChanged: (dateTime) {
            if (mode == CupertinoDatePickerMode.date) {
              _handleDateChanged(dateTime, isStarts);
            } else {
              _handleTimeChanged(dateTime, isStarts);
            }

            setState(() {});
          },
        ),
      );

  void _handleDateChanged(DateTime dateTime, bool isStarts) {
    if (isStarts) {
      _startDate = dateTime;
    } else {
      _endDate = dateTime;
    }
  }

  void _handleTimeChanged(DateTime dateTime, bool isStarts) {
    if (isStarts) {
      _startTime = TimeOfDay.fromDateTime(dateTime);
    } else {
      _endTime = TimeOfDay.fromDateTime(dateTime);
    }
  }
}
