import 'dart:math';

/// [NotifyUtils] contains a method that generates an ID in int format from
/// the timestamp of the start time of the event. ID is used to create local notifications
class NotifyUtils {
  int creatingIdForNotify({required int timestamp}) {
    // Generating a random four-digit number
    int randomFourDigits = Random().nextInt(9000) + 1000;
    int lastTimestampDigit = timestamp % 10;
    int id = randomFourDigits * 10 + lastTimestampDigit;

    return id;
  }
}
