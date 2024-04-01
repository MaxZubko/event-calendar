import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PickerUtils {
  static Future<void> showCupertinoSheet({
    required BuildContext context,
    required Widget child,
    required VoidCallback onClicked,
  }) async =>
      await showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            child,
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: onClicked,
            child: const Text('Done'),
          ),
        ),
      );

  static Future<DateTime?> showMaterialDateSheet({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
  }) async =>
      await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate,
      );

  static Future<TimeOfDay?> showMaterialTimeSheet({
    required BuildContext context,
    required TimeOfDay initialTime,
  }) async =>
      await showTimePicker(
        context: context,
        initialTime: initialTime,
      );
}
