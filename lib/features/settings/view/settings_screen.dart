import 'package:event_calendar_app/cubit/theme/cubit/theme_cubit.dart';
import 'package:event_calendar_app/features/settings/widgets/widgets.dart';
import 'package:event_calendar_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Settings',
        textStyle: theme.textTheme.headlineMedium,
      ),
      body: Column(
        children: [
          Builder(
            builder: (context) {
              final isDarkTheme = context.watch<ThemeCubit>().state.isDark;

              return SettingsToggleCard(
                title: 'Dark Theme',
                style: theme.textTheme.titleMedium,
                value: isDarkTheme,
                onChanged: (value) => _setThemeBrightness(context, value),
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Divider(),
          ),
        ],
      ),
    );
  }

  void _setThemeBrightness(BuildContext context, bool value) {
    context.read<ThemeCubit>().setThemeBrightness(
          value ? Brightness.dark : Brightness.light,
        );
  }
}
