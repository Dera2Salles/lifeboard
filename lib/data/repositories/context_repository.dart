import 'package:isar/isar.dart';
import '../datasources/isar_database.dart';
import '../models/context_entry.dart';

class ContextRepository {
  Isar get _db => IsarDatabase.instance.isar;

  Future<List<ContextEntry>> getContextsForPerson(int personId) async {
    return await _db.contextEntrys
        .filter()
        .personIdEqualTo(personId)
        .sortByImportanceDesc()
        .thenByDateDesc()
        .findAll();
  }

  Future<List<ContextEntry>> getContextsByCategory(
    int personId,
    String category,
  ) async {
    return await _db.contextEntrys
        .filter()
        .personIdEqualTo(personId)
        .categoryEqualTo(category)
        .sortByDateDesc()
        .findAll();
  }

  Future<List<ContextEntry>> getHighImportanceContexts(int personId) async {
    return await _db.contextEntrys
        .filter()
        .personIdEqualTo(personId)
        .importanceGreaterThan(3)
        .sortByImportanceDesc()
        .findAll();
  }

  Future<void> saveContext(ContextEntry entry) async {
    await _db.writeTxn(() async {
      await _db.contextEntrys.put(entry);
    });
  }

  Future<void> deleteContext(int id) async {
    await _db.writeTxn(() async {
      await _db.contextEntrys.delete(id);
    });
  }
}
