import 'package:isar/isar.dart';
import '../datasources/isar_database.dart';
import '../models/interaction.dart';

class InteractionRepository {
  Isar get _db => IsarDatabase.instance.isar;

  Future<List<Interaction>> getInteractionsForPerson(int personId) async {
    return await _db.interactions
        .filter()
        .personIdEqualTo(personId)
        .sortByDateDesc()
        .findAll();
  }

  Future<List<Interaction>> getRecentInteractions(int personId, {int limit = 10}) async {
    return await _db.interactions
        .filter()
        .personIdEqualTo(personId)
        .sortByDateDesc()
        .limit(limit)
        .findAll();
  }

  Future<Interaction?> getLastInteraction(int personId) async {
    return await _db.interactions
        .filter()
        .personIdEqualTo(personId)
        .sortByDateDesc()
        .findFirst();
  }

  Future<double> getAverageQuality(int personId) async {
    final interactions = await getInteractionsForPerson(personId);
    if (interactions.isEmpty) return 0;
    final total = interactions.fold(0, (sum, i) => sum + i.qualityScore);
    return total / interactions.length;
  }

  Future<Map<String, int>> getInteractionCountByType(int personId) async {
    final interactions = await getInteractionsForPerson(personId);
    final Map<String, int> counts = {};
    for (final i in interactions) {
      counts[i.type] = (counts[i.type] ?? 0) + 1;
    }
    return counts;
  }

  Future<void> saveInteraction(Interaction interaction) async {
    await _db.writeTxn(() async {
      await _db.interactions.put(interaction);
    });
  }

  Future<void> deleteInteraction(int id) async {
    await _db.writeTxn(() async {
      await _db.interactions.delete(id);
    });
  }
}
