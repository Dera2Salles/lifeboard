import 'package:isar/isar.dart';
import '../datasources/isar_database.dart';
import '../models/person.dart';
import '../models/profile.dart';
import '../models/relationship_score.dart';

class PersonRepository {
  Isar get _db => IsarDatabase.instance.isar;

  // ─── Persons ────────────────────────────────────────────────────────────────

  Future<List<Person>> getAllPersons() async {
    return await _db.persons.where().sortByCreatedAtDesc().findAll();
  }

  Future<Person?> getPersonById(int id) async {
    return await _db.persons.get(id);
  }

  Future<List<Person>> searchPersons(String query) async {
    return await _db.persons
        .filter()
        .nameContains(query, caseSensitive: false)
        .findAll();
  }

  Future<List<Person>> getPersonsByRelationType(RelationType type) async {
    return await _db.persons
        .filter()
        .relationTypeEqualTo(type)
        .sortByCreatedAtDesc()
        .findAll();
  }

  Future<int> savePerson(Person person) async {
    return await _db.writeTxn(() async {
      return await _db.persons.put(person);
    });
  }

  Future<void> deletePerson(int id) async {
    await _db.writeTxn(() async {
      await _db.persons.delete(id);
      // Supprimer les données liées
      final profile = await _db.profiles.filter().personIdEqualTo(id).findFirst();
      if (profile != null) await _db.profiles.delete(profile.id);

      final scores = await _db.relationshipScores.filter().personIdEqualTo(id).findAll();
      for (final s in scores) {
        await _db.relationshipScores.delete(s.id);
      }
    });
  }

  // ─── Profiles ───────────────────────────────────────────────────────────────

  Future<Profile?> getProfileByPersonId(int personId) async {
    return await _db.profiles.filter().personIdEqualTo(personId).findFirst();
  }

  Future<void> saveProfile(Profile profile) async {
    profile.updatedAt = DateTime.now();
    await _db.writeTxn(() async {
      await _db.profiles.put(profile);
    });
  }

  // ─── Relationship Scores ─────────────────────────────────────────────────────

  Future<RelationshipScore?> getScoreByPersonId(int personId) async {
    return await _db.relationshipScores
        .filter()
        .personIdEqualTo(personId)
        .findFirst();
  }

  Future<void> saveScore(RelationshipScore score) async {
    await _db.writeTxn(() async {
      await _db.relationshipScores.put(score);
    });
  }

  Future<RelationshipScore> getOrCreateScore(int personId) async {
    final existing = await getScoreByPersonId(personId);
    if (existing != null) return existing;
    final score = RelationshipScore()
      ..personId = personId
      ..score = 50
      ..trustLevel = 50
      ..communicationLevel = 50
      ..emotionalCloseness = 50
      ..lastEvaluated = DateTime.now();
    await saveScore(score);
    return score;
  }
}
