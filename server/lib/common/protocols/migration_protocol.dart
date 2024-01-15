abstract interface class MigrationProtocol {
  Future<void> up({int? count});
  Future<void> down({int? count});
}
