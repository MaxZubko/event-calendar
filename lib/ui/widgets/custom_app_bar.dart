import 'package:event_calendar_app/cubit/theme/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:event_calendar_app/constants/constants.dart' as constants;

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Icon? iconActionBtn;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;
  const CustomAppBar({
    super.key,
    required this.title,
    this.iconActionBtn,
    this.onPressed,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: textStyle,
      ),
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      actions: iconActionBtn != null
          ? [
              Builder(
                builder: (context) {
                  final isDarkTheme = context.watch<ThemeCubit>().state.isDark;

                  return IconButton(
                    onPressed: onPressed,
                    icon: iconActionBtn!,
                    color: isDarkTheme
                        ? constants.Colors.white
                        : constants.Colors.dark,
                  );
                },
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
