import 'package:isar/isar.dart';

part 'user.g.dart';

@collection
class User {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String name;

  String? personalityType;
  String? loveLanguage;

  List<String> strengths = [];
  List<String> goals = [];
  List<String> highlights = []; // Insights "À retenir sur moi"

  // Radar chart data (stored as a list of doubles for specific traits)
  List<double> radarValues = [0.5, 0.5, 0.5, 0.5, 0.5, 0.5];
  List<String> radarLabels = ['Curiosité', 'Empathie', 'Discipline', 'Créativité', 'Résilience', 'Communication'];

  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();
}
