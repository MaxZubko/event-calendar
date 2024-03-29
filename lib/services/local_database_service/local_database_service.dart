import 'package:event_calendar_app/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDatabaseService implements LocalDatabaseServiceInterface {
  final SharedPreferences _sharedPrefs;

  LocalDatabaseService({required SharedPreferences sharedPrefs})
      : _sharedPrefs = sharedPrefs;

  @override
  Future<String?> getDocId() async {
    // TODO make it a constant
    final String? docId = _sharedPrefs.getString('docId');

    return docId;
  }

  @override
  Future<void> saveDocId({required String id}) async {
    // TODO make it a constant
    await _sharedPrefs.setString('docId', id);
  }
}
