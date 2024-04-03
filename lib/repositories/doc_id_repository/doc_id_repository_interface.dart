abstract interface class DocIdRepositoryInterface {
  Future<String?> getDocId();
  Future<void> saveDocId({required String id});
}
