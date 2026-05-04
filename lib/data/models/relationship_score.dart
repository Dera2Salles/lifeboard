import 'package:isar/isar.dart';

part 'relationship_score.g.dart';

@collection
class RelationshipScore {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late int personId;

  late double score;             // 0-100

  late double trustLevel;        // 0-100
  late double communicationLevel; // 0-100
  late double emotionalCloseness; // 0-100

  late DateTime lastEvaluated;

  @ignore
  String get scoreLabel {
    if (score >= 80) return 'Excellente';
    if (score >= 60) return 'Bonne';
    if (score >= 40) return 'Moyenne';
    if (score >= 20) return 'Fragile';
    return 'Critique';
  }

  @ignore
  String get scoreEmoji {
    if (score >= 80) return '🌟';
    if (score >= 60) return '💚';
    if (score >= 40) return '💛';
    if (score >= 20) return '🧡';
    return '❤️‍🩹';
  }
}
