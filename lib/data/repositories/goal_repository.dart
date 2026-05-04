import 'package:isar/isar.dart';
import '../datasources/isar_database.dart';
import '../models/goal.dart';

class GoalRepository {
  Isar get _db => IsarDatabase.instance.isar;

  Future<List<Goal>> getAllGoals() async {
    return await _db.goals.where().sortByCreatedAtDesc().findAll();
  }

  Future<List<Goal>> getGoalsForPerson(int personId) async {
    return await _db.goals
        .filter()
        .personIdEqualTo(personId)
        .sortByCreatedAtDesc()
        .findAll();
  }

  Future<List<Goal>> getActiveGoals() async {
    return await _db.goals
        .filter()
        .statusEqualTo('en_cours')
        .sortByCreatedAtDesc()
        .findAll();
  }

  Future<void> saveGoal(Goal goal) async {
    await _db.writeTxn(() async {
      await _db.goals.put(goal);
    });
  }

  Future<void> updateProgress(int goalId, double progress) async {
    final goal = await _db.goals.get(goalId);
    if (goal == null) return;
    await _db.writeTxn(() async {
      goal.progress = progress;
      goal.updatedAt = DateTime.now();
      if (progress >= 100) goal.status = 'complété';
      await _db.goals.put(goal);
    });
  }

  Future<void> deleteGoal(int id) async {
    await _db.writeTxn(() async {
      await _db.goals.delete(id);
    });
  }
}
