import 'package:event_calendar_app/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDatabaseService implements LocalDatabaseServiceInterface {
  @override
  Future<String?> getDocId() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    // TODO make it a constant
    final String? docId = sharedPrefs.getString('docId');

    return docId;
  }

  @override
  Future<void> saveDocId({required String id}) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    // TODO make it a constant
    await sharedPrefs.setString('docId', id);
  }
}
