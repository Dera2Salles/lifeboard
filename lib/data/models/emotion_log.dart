import 'package:isar/isar.dart';

part 'emotion_log.g.dart';

@collection
class EmotionLog {
  Id id = Isar.autoIncrement;

  late int personId;

  late String emotion;    // joie, tristesse, colère, peur...

  @Index()
  late int intensity;     // 1-10

  String? context;        // Dans quel contexte

  DateTime date = DateTime.now();

  String? note;           // Note libre

  @ignore
  String get emoji {
    const Map<String, String> emojis = {
      'joie': '😊',
      'tristesse': '😢',
      'colère': '😠',
      'peur': '😨',
      'surprise': '😲',
      'dégoût': '🤢',
      'anticipation': '🤩',
      'confiance': '🤝',
      'neutre': '😐',
    };
    return emojis[emotion] ?? '😐';
  }
}
