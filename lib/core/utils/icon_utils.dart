import 'package:flutter/material.dart';

class IconUtils {
  static IconData getIconForRelation(String type) {
    switch (type.toLowerCase()) {
      case 'ami':
        return Icons.people_outline_rounded;
      case 'famille':
        return Icons.family_restroom_rounded;
      case 'partenaire':
        return Icons.favorite_outline_rounded;
      case 'collegue':
        return Icons.work_outline_rounded;
      case 'mentor':
        return Icons.psychology_outlined;
      case 'connaissance':
        return Icons.handshake_outlined;
      default:
        return Icons.person_outline_rounded;
    }
  }

  static IconData getIconForMood(String? mood) {
    switch (mood) {
      case 'Super':
        return Icons.sentiment_very_satisfied_rounded;
      case 'Bien':
        return Icons.sentiment_satisfied_rounded;
      case 'Ok':
        return Icons.sentiment_neutral_rounded;
      case 'Pas top':
        return Icons.sentiment_dissatisfied_rounded;
      case 'Mal':
        return Icons.sentiment_very_dissatisfied_rounded;
      default:
        return Icons.sentiment_neutral_rounded;
    }
  }

  static IconData getIconForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'santé':
        return Icons.favorite_rounded;
      case 'travail':
        return Icons.work_rounded;
      case 'sport':
        return Icons.fitness_center_rounded;
      case 'lecture':
        return Icons.menu_book_rounded;
      case 'méditation':
        return Icons.self_improvement_rounded;
      case 'social':
        return Icons.groups_rounded;
      default:
        return Icons.star_rounded;
    }
  }

  static IconData getIconForInsight(String title) {
    if (title.contains('proches')) return Icons.lightbulb_outline_rounded;
    if (title.contains('streak')) return Icons.local_fire_department_rounded;
    if (title.contains('Croissance')) return Icons.eco_rounded;
    if (title.contains('Focus')) return Icons.track_changes_rounded;
    return Icons.auto_awesome_rounded;
  }
}
