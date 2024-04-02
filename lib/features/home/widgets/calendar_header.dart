import 'package:event_calendar_app/features/home/cubit/calendar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:event_calendar_app/constants/constants.dart' as constants;

class CalendarHeader extends StatelessWidget {
  const CalendarHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        const SizedBox(width: 8),
        BlocBuilder<CalendarCubit, CalendarState>(
          builder: (context, state) {
            return Text(
              '${_getMonthName(state.currentDate.month)} ${state.currentDate.year.toString()}',
              style: theme.textTheme.titleLarge,
            );
          },
        ),
        const Expanded(child: SizedBox()),
        IconButton(
          icon: SvgPicture.asset(
            constants.Assets.arrowLeftSvg,
            color: constants.Colors.white,
          ),
          onPressed: () {
            final cubit = context.read<CalendarCubit>();
            cubit.previousMonth();
          },
        ),
        IconButton(
          icon: SvgPicture.asset(
            constants.Assets.arrowRightSvg,
            color: constants.Colors.white,
          ),
          onPressed: () {
            final cubit = context.read<CalendarCubit>();
            cubit.nextMonth();
          },
        ),
      ],
    );
  }

  String _getMonthName(int month) {
    List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }
}
