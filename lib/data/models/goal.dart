import 'package:isar/isar.dart';

part 'goal.g.dart';

@collection
class Goal {
  Id id = Isar.autoIncrement;

  int? personId; // nullable — objectif lié à une personne ou non

  late String title;

  String? description;

  DateTime? deadline;

  late double progress; // 0-100

  late String status; // en_cours, complété, en_pause, abandonné

  List<String> milestones = []; // Étapes

  late DateTime createdAt;

  late DateTime updatedAt;

  @ignore
  String get statusLabel {
    switch (status) {
      case 'en_cours':
        return 'En cours';
      case 'complété':
        return 'Complété ✅';
      case 'en_pause':
        return 'En pause ⏸';
      case 'abandonné':
        return 'Abandonné';
      default:
        return status;
    }
  }
}
