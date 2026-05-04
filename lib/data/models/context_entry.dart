import 'package:isar/isar.dart';

part 'context_entry.g.dart';

@collection
class ContextEntry {
  Id id = Isar.autoIncrement;

  late int personId;

  late String title;

  late String description;

  late String category; // travail, famille, santé, rêve, traumatisme, souvenir...

  @Index()
  late int importance; // 1-5

  DateTime date = DateTime.now();

  List<String> tags = [];

  DateTime createdAt = DateTime.now();
}
