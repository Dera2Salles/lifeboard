import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/habit.dart';
import '../../../data/models/habit_log.dart';
import '../../../data/repositories/habit_repository.dart';

final habitRepositoryProvider = Provider<HabitRepository>((ref) {
  return HabitRepository();
});

final habitsProvider = AsyncNotifierProvider<HabitsNotifier, List<Habit>>(
  HabitsNotifier.new,
);

class HabitsNotifier extends AsyncNotifier<List<Habit>> {
  HabitRepository get _repo => ref.read(habitRepositoryProvider);

  @override
  Future<List<Habit>> build() async {
    return await _repo.getAllHabits();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repo.getAllHabits());
  }

  Future<void> addHabit(Habit habit) async {
    await _repo.saveHabit(habit);
    await refresh();
  }

  Future<void> toggleToday(int habitId) async {
    await _repo.toggleHabitLog(habitId, DateTime.now());
    await refresh();
  }

  Future<void> deleteHabit(int id) async {
    await _repo.deleteHabit(id);
    await refresh();
  }
}

final todayHabitLogsProvider = FutureProvider<Map<int, HabitLog?>>((ref) async {
  final habits = await ref.watch(habitsProvider.future);
  final repo = ref.read(habitRepositoryProvider);
  final Map<int, HabitLog?> result = {};
  for (final habit in habits) {
    result[habit.id] = await repo.getLogForDate(habit.id, DateTime.now());
  }
  return result;
});

final habitHeatmapProvider = FutureProvider.family<Map<DateTime, bool>, int>((ref, habitId) async {
  final repo = ref.read(habitRepositoryProvider);
  return repo.getHeatmapData(habitId);
});

final habitLogsProvider = FutureProvider.family<List<HabitLog>, int>((ref, habitId) async {
  final repo = ref.read(habitRepositoryProvider);
  return repo.getLogsForHabit(habitId);
});
