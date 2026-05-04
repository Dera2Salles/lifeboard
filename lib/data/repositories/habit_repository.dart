import 'package:isar/isar.dart';
import '../datasources/isar_database.dart';
import '../models/habit.dart';
import '../models/habit_log.dart';

class HabitRepository {
  Isar get _db => IsarDatabase.instance.isar;

  Future<List<Habit>> getAllHabits() async {
    return await _db.habits
        .filter()
        .isActiveEqualTo(true)
        .sortByCreatedAt()
        .findAll();
  }

  Future<Habit?> getHabitById(int id) async {
    return await _db.habits.get(id);
  }

  Future<void> saveHabit(Habit habit) async {
    await _db.writeTxn(() async {
      await _db.habits.put(habit);
    });
  }

  Future<void> deleteHabit(int id) async {
    await _db.writeTxn(() async {
      await _db.habits.delete(id);
      final logs = await _db.habitLogs.filter().habitIdEqualTo(id).findAll();
      await _db.habitLogs.deleteAll(logs.map((l) => l.id).toList());
    });
  }

  // ─── Habit Logs ──────────────────────────────────────────────────────────────

  Future<HabitLog?> getLogForDate(int habitId, DateTime date) async {
    final dayStart = DateTime(date.year, date.month, date.day);
    final dayEnd = dayStart.add(const Duration(days: 1));
    return await _db.habitLogs
        .filter()
        .habitIdEqualTo(habitId)
        .dateBetween(dayStart, dayEnd)
        .findFirst();
  }

  Future<List<HabitLog>> getLogsForHabit(int habitId, {int limit = 60}) async {
    return await _db.habitLogs
        .filter()
        .habitIdEqualTo(habitId)
        .sortByDateDesc()
        .limit(limit)
        .findAll();
  }

  Future<List<HabitLog>> getLogsForDateRange(
    int habitId,
    DateTime from,
    DateTime to,
  ) async {
    return await _db.habitLogs
        .filter()
        .habitIdEqualTo(habitId)
        .dateBetween(from, to)
        .sortByDate()
        .findAll();
  }

  Future<void> toggleHabitLog(int habitId, DateTime date) async {
    await _db.writeTxn(() async {
      final existing = await getLogForDate(habitId, date);
      if (existing != null) {
        existing.completed = !existing.completed;
        await _db.habitLogs.put(existing);
      } else {
        final log = HabitLog()
          ..habitId = habitId
          ..date = DateTime(date.year, date.month, date.day)
          ..completed = true;
        await _db.habitLogs.put(log);
      }
    });
    await _recalculateStreak(habitId);
  }

  Future<void> _recalculateStreak(int habitId) async {
    final habit = await getHabitById(habitId);
    if (habit == null) return;

    final logs = await getLogsForHabit(habitId, limit: 365);
    final completedDates = logs
        .where((l) => l.completed)
        .map((l) => DateTime(l.date.year, l.date.month, l.date.day))
        .toSet();

    int streak = 0;
    int bestStreak = 0;
    int currentStreak = 0;
    DateTime check = DateTime.now();

    for (int i = 0; i < 365; i++) {
      final day = DateTime(check.year, check.month, check.day)
          .subtract(Duration(days: i));
      if (completedDates.contains(day)) {
        currentStreak++;
        if (i == 0 || i == 1) streak = currentStreak;
        if (currentStreak > bestStreak) bestStreak = currentStreak;
      } else {
        if (i > 1) currentStreak = 0;
      }
    }

    await _db.writeTxn(() async {
      habit.streak = streak;
      habit.bestStreak = bestStreak;
      await _db.habits.put(habit);
    });
  }

  Future<Map<DateTime, bool>> getHeatmapData(int habitId, {int days = 90}) async {
    final from = DateTime.now().subtract(Duration(days: days));
    final logs = await getLogsForDateRange(habitId, from, DateTime.now());
    return {
      for (final log in logs)
        DateTime(log.date.year, log.date.month, log.date.day): log.completed,
    };
  }
}
