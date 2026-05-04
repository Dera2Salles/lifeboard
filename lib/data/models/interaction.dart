import 'package:isar/isar.dart';

part 'interaction.g.dart';

@collection
class Interaction {
  Id id = Isar.autoIncrement;

  late int personId;

  late String type; // conversation, dispute, célébration, aide...

  late String summary;

  @Index()
  late int qualityScore; // 1-10

  String? moodBefore;

  String? moodAfter;

  String? lessonsLearned;

  DateTime date = DateTime.now();

  DateTime createdAt = DateTime.now();

  @ignore
  String get typeIcon {
    const Map<String, String> icons = {
      'conversation': '💬',
      'dispute': '⚡',
      'célébration': '🎉',
      'aide': '🤝',
      'rendez-vous': '📅',
      'message': '📩',
      'appel': '📞',
      'activité': '🎯',
      'autre': '✏️',
    };
    return icons[type] ?? '✏️';
  }
}
