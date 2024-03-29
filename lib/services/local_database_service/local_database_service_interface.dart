abstract interface class LocalDatabaseServiceInterface {
  Future<String?> getDocId();
  Future<void> saveDocId({required String id});
}
