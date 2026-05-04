import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/person.dart';
import '../models/profile.dart';
import '../models/emotion_log.dart';
import '../models/context_entry.dart';
import '../models/interaction.dart';
import '../models/relationship_score.dart';
import '../models/habit.dart';
import '../models/habit_log.dart';
import '../models/goal.dart';
import '../models/user.dart';

class IsarDatabase {
  IsarDatabase._();
  static final IsarDatabase instance = IsarDatabase._();

  Isar? _isar;

  Isar get isar {
    if (_isar == null) throw StateError('Isar not initialized. Call init() first.');
    return _isar!;
  }

  Future<void> init() async {
    if (_isar != null && _isar!.isOpen) return;
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [
        PersonSchema,
        ProfileSchema,
        EmotionLogSchema,
        ContextEntrySchema,
        InteractionSchema,
        RelationshipScoreSchema,
        HabitSchema,
        HabitLogSchema,
        GoalSchema,
        UserSchema,
      ],
      directory: dir.path,
      name: 'lifeboard_db',
    );
  }

  Future<void> close() async {
    await _isar?.close();
  }
}
