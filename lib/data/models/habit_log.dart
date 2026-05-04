import 'package:isar/isar.dart';

part 'habit_log.g.dart';

@collection
class HabitLog {
  Id id = Isar.autoIncrement;

  late int habitId;

  @Index(composite: [CompositeIndex('habitId')])
  late DateTime date;

  late bool completed;

  String? note;
}
