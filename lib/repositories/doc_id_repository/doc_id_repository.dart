import 'package:event_calendar_app/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'doc_id.dart';

class DocIdRepository implements DocIdRepositoryInterface {
  // final SharedPreferences _sharedPrefs;

  // DocIdRepository({required SharedPreferences sharedPrefs})
  //     : _sharedPrefs = sharedPrefs;
  @override
  Future<String?> getDocId() async {
    // TODO take out the SharedPreferences instance
    final sharedPrefs = await SharedPreferences.getInstance();
    final String? docId = sharedPrefs.getString(SHARED_PREF_KEY);

    return docId;
  }

  @override
  Future<void> saveDocId({required String id}) async {
    // TODO take out the SharedPreferences instance
    final sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.setString(SHARED_PREF_KEY, id);
  }
}
