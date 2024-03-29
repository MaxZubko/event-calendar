import 'package:event_calendar_app/features/home/cubit/calendar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:event_calendar_app/constants/constants.dart' as constants;

class CalendarHeader extends StatelessWidget {
  const CalendarHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocBuilder<CalendarCubit, CalendarState>(
          builder: (context, state) {
            return Text(
              '${state.currentDate.month.toString()} ${state.currentDate.year.toString()}',
            );
          },
        ),
        const Expanded(child: SizedBox()),
        IconButton(
          icon: SvgPicture.asset(constants.Assets.arrowLeftSvg),
          onPressed: () {
            final cubit = context.read<CalendarCubit>();
            cubit.previousMonth();
          },
        ),
        IconButton(
          icon: SvgPicture.asset(constants.Assets.arrowRightSvg),
          onPressed: () {
            final cubit = context.read<CalendarCubit>();
            cubit.nextMonth();
          },
        ),
      ],
    );
  }
}
