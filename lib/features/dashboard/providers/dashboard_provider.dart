import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/person.dart';
import '../../../data/models/habit.dart';
import '../../../data/repositories/person_repository.dart';
import '../../../data/repositories/habit_repository.dart';

class DashboardData {
  final List<Person> recentPersons;
  final List<Habit> todayHabits;
  final int completedToday;
  final double globalScore;
  final String greeting;

  const DashboardData({
    required this.recentPersons,
    required this.todayHabits,
    required this.completedToday,
    required this.globalScore,
    required this.greeting,
  });
}

final dashboardProvider = FutureProvider<DashboardData>((ref) async {
  final personRepo = PersonRepository();
  final habitRepo = HabitRepository();

  final persons = await personRepo.getAllPersons();
  final habits = await habitRepo.getAllHabits();

  // Calcul des habitudes du jour complétées
  int completed = 0;
  for (final habit in habits) {
    final log = await habitRepo.getLogForDate(habit.id, DateTime.now());
    if (log != null && log.completed) completed++;
  }

  // Score global
  double totalScore = 0;
  for (final person in persons) {
    final score = await personRepo.getOrCreateScore(person.id);
    totalScore += score.score;
  }
  final globalScore = persons.isEmpty ? 50.0 : totalScore / persons.length;

  // Salutation selon l'heure
  final hour = DateTime.now().hour;
  final greeting = hour < 12
      ? 'Bonjour ☀️'
      : hour < 18
          ? 'Bonne après-midi 🌤'
          : 'Bonsoir 🌙';

  return DashboardData(
    recentPersons: persons.take(5).toList(),
    todayHabits: habits,
    completedToday: completed,
    globalScore: globalScore,
    greeting: greeting,
  );
});

// Provider pour la sélection d'humeur du jour
final todayMoodProvider = StateProvider<String?>((ref) => null);
