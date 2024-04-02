import 'package:event_calendar_app/constants/constants.dart';
import 'package:event_calendar_app/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDatabaseService implements LocalDatabaseServiceInterface {
  @override
  Future<String?> getDocId() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final String? docId = sharedPrefs.getString(SHARED_PREF_KEY);

    return docId;
  }

  @override
  Future<void> saveDocId({required String id}) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.setString(SHARED_PREF_KEY, id);
  }
}
