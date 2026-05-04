import 'package:isar/isar.dart';

part 'habit.g.dart';

@collection
class Habit {
  Id id = Isar.autoIncrement;

  int? personId; // nullable — habitude liée à une personne ou non

  late String title;

  late String frequency; // daily, weekly, monthly

  int targetDays = 1; // Nb de fois par période

  int streak = 0; // Streak actuel

  int bestStreak = 0;

  late String category; // santé, relation, développement...

  late int color; // Couleur ARGB

  late String icon; // Emoji

  late DateTime createdAt;

  bool isActive = true;

  @ignore
  String get frequencyLabel {
    switch (frequency) {
      case 'daily':
        return 'Quotidien';
      case 'weekly':
        return 'Hebdomadaire';
      case 'monthly':
        return 'Mensuel';
      default:
        return frequency;
    }
  }
}
