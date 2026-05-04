import 'package:isar/isar.dart';
import '../datasources/isar_database.dart';
import '../models/emotion_log.dart';

class EmotionRepository {
  Isar get _db => IsarDatabase.instance.isar;

  Future<List<EmotionLog>> getEmotionsForPerson(int personId) async {
    return await _db.emotionLogs
        .filter()
        .personIdEqualTo(personId)
        .sortByDateDesc()
        .findAll();
  }

  Future<List<EmotionLog>> getRecentEmotions(int personId, {int limit = 30}) async {
    return await _db.emotionLogs
        .filter()
        .personIdEqualTo(personId)
        .sortByDateDesc()
        .limit(limit)
        .findAll();
  }

  Future<List<EmotionLog>> getEmotionsBetweenDates(
    int personId,
    DateTime from,
    DateTime to,
  ) async {
    return await _db.emotionLogs
        .filter()
        .personIdEqualTo(personId)
        .dateBetween(from, to)
        .sortByDate()
        .findAll();
  }

  Future<void> saveEmotion(EmotionLog log) async {
    await _db.writeTxn(() async {
      await _db.emotionLogs.put(log);
    });
  }

  Future<void> deleteEmotion(int id) async {
    await _db.writeTxn(() async {
      await _db.emotionLogs.delete(id);
    });
  }

  /// Retourne la moyenne des intensités par émotion
  Future<Map<String, double>> getEmotionAverages(int personId) async {
    final logs = await getEmotionsForPerson(personId);
    final Map<String, List<int>> byEmotion = {};
    for (final log in logs) {
      byEmotion.putIfAbsent(log.emotion, () => []).add(log.intensity);
    }
    return byEmotion.map((emotion, intensities) {
      final avg = intensities.reduce((a, b) => a + b) / intensities.length;
      return MapEntry(emotion, avg);
    });
  }
}
