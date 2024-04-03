import 'package:flutter/cupertino.dart';
import 'package:event_calendar_app/constants/constants.dart' as constants;

class SettingsToggleCard extends StatelessWidget {
  const SettingsToggleCard({
    super.key,
    required this.title,
    required this.value,
    this.onChanged,
    required this.style,
  });

  final String title;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: style,
            ),
            CupertinoSwitch(
              value: value,
              activeColor: constants.Colors.greenSelected,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
