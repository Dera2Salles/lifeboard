import 'package:isar/isar.dart';
import '../datasources/isar_database.dart';
import '../models/user.dart';

class UserRepository {
  Isar get _db => IsarDatabase.instance.isar;

  Future<User?> getCurrentUser() async {
    return await _db.users.where().findFirst();
  }

  Future<void> saveUser(User user) async {
    await _db.writeTxn(() async {
      user.updatedAt = DateTime.now();
      await _db.users.put(user);
    });
  }

  Future<User> getOrCreateUser() async {
    final existing = await getCurrentUser();
    if (existing != null) return existing;

    final user = User()
      ..name = 'Utilisateur'
      ..personalityType = 'INFP'
      ..loveLanguage = 'Paroles valorisantes'
      ..strengths = ['Empathie', 'Créativité', 'Écoute']
      ..goals = [
        'Être plus présent pour mes proches',
        'Développer ma discipline quotidienne',
        'Améliorer ma communication'
      ]
      ..highlights = [
        'Tu progresses chaque jour.',
        'Concentre-toi sur l\'essentiel.'
      ]
      ..radarValues = [0.8, 0.7, 0.6, 0.9, 0.5, 0.75];

    await saveUser(user);
    return user;
  }
}
