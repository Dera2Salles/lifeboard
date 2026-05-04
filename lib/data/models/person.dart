import 'package:isar/isar.dart';

part 'person.g.dart';

enum RelationType {
  ami,
  famille,
  partenaire,
  collegue,
  mentor,
  connaissance,
  autre,
}

@collection
class Person {
  Id id = Isar.autoIncrement;

  late String name;

  String? avatar; // emoji ou chemin image

  @Enumerated(EnumType.name)
  RelationType relationType = RelationType.ami;

  DateTime? metAt;

  DateTime? birthday;

  String? notes;

  late DateTime createdAt;

  @ignore
  String get relationTypeLabel {
    switch (relationType) {
      case RelationType.ami:
        return 'Ami';
      case RelationType.famille:
        return 'Famille';
      case RelationType.partenaire:
        return 'Partenaire';
      case RelationType.collegue:
        return 'Collègue';
      case RelationType.mentor:
        return 'Mentor';
      case RelationType.connaissance:
        return 'Connaissance';
      case RelationType.autre:
        return 'Autre';
    }
  }

  @ignore
  String get avatarEmoji {
    if (avatar != null && avatar!.isNotEmpty) return avatar!;
    switch (relationType) {
      case RelationType.ami:
        return '👫';
      case RelationType.famille:
        return '👨‍👩‍👧';
      case RelationType.partenaire:
        return '❤️';
      case RelationType.collegue:
        return '💼';
      case RelationType.mentor:
        return '🧠';
      case RelationType.connaissance:
        return '🤝';
      case RelationType.autre:
        return '✨';
    }
  }
}
