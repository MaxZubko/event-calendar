import 'package:event_calendar_app/cubit/theme/cubit/theme_cubit.dart';
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
          icon: _icon(constants.Assets.arrowLeftSvg),
          onPressed: () {
            final cubit = context.read<CalendarCubit>();
            cubit.previousMonth();
          },
        ),
        IconButton(
          icon: _icon(constants.Assets.arrowRightSvg),
          onPressed: () {
            final cubit = context.read<CalendarCubit>();
            cubit.nextMonth();
          },
        ),
      ],
    );
  }

  Widget _icon(String path) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final bool isDarkTheme = state.isDark;
        return SvgPicture.asset(
          path,
          color: isDarkTheme ? constants.Colors.white : constants.Colors.dark,
        );
      },
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
