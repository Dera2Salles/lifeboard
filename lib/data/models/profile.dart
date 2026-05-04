import 'package:isar/isar.dart';

part 'profile.g.dart';

@collection
class Profile {
  Id id = Isar.autoIncrement;

  late int personId;

  List<String> desires = [];    // Ce qu'elle désire
  List<String> dreams = [];     // Ses rêves
  List<String> fears = [];      // Ses peurs
  List<String> loves = [];      // Ce qu'elle aime
  List<String> dislikes = [];   // Ce qu'elle n'aime pas
  List<String> values = [];     // Ses valeurs

  String? loveLanguage;         // Langage d'amour
  String? personalityType;      // MBTI / introverti / extraverti
  String? notes;

  DateTime updatedAt = DateTime.now();
}
