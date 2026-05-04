abstract class AppConstants {
  // ─── Relation Types ─────────────────────────────────────────────────────────
  static const List<String> relationTypes = [
    'ami',
    'famille',
    'partenaire',
    'collègue',
    'mentor',
    'connaissance',
    'autre',
  ];

  static const Map<String, String> relationTypeIcons = {
    'ami': '👫',
    'famille': '👨‍👩‍👧',
    'partenaire': '❤️',
    'collègue': '💼',
    'mentor': '🧠',
    'connaissance': '🤝',
    'autre': '✨',
  };

  // ─── Emotions ────────────────────────────────────────────────────────────────
  static const List<String> emotions = [
    'joie',
    'tristesse',
    'colère',
    'peur',
    'surprise',
    'dégoût',
    'anticipation',
    'confiance',
    'neutre',
  ];

  static const Map<String, String> emotionEmojis = {
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

  // ─── Context Categories ──────────────────────────────────────────────────────
  static const List<String> contextCategories = [
    'travail',
    'famille',
    'santé',
    'rêve',
    'traumatisme',
    'souvenir',
    'accomplissement',
    'difficulté',
    'voyage',
    'autre',
  ];

  static const Map<String, String> contextCategoryIcons = {
    'travail': '💼',
    'famille': '👨‍👩‍👧',
    'santé': '🏥',
    'rêve': '✨',
    'traumatisme': '💔',
    'souvenir': '📸',
    'accomplissement': '🏆',
    'difficulté': '⚡',
    'voyage': '✈️',
    'autre': '📌',
  };

  // ─── Interaction Types ───────────────────────────────────────────────────────
  static const List<String> interactionTypes = [
    'conversation',
    'dispute',
    'célébration',
    'aide',
    'rendez-vous',
    'message',
    'appel',
    'activité',
    'autre',
  ];

  static const Map<String, String> interactionTypeIcons = {
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

  // ─── Habit Frequencies ───────────────────────────────────────────────────────
  static const List<String> habitFrequencies = [
    'daily',
    'weekly',
    'monthly',
  ];

  static const Map<String, String> habitFrequencyLabels = {
    'daily': 'Quotidien',
    'weekly': 'Hebdomadaire',
    'monthly': 'Mensuel',
  };

  // ─── Habit Categories ────────────────────────────────────────────────────────
  static const List<String> habitCategories = [
    'santé',
    'relation',
    'développement',
    'créativité',
    'spiritualité',
    'autre',
  ];

  static const Map<String, String> habitCategoryIcons = {
    'santé': '💪',
    'relation': '❤️',
    'développement': '📚',
    'créativité': '🎨',
    'spiritualité': '🧘',
    'autre': '⭐',
  };

  // ─── Love Languages ──────────────────────────────────────────────────────────
  static const List<String> loveLanguages = [
    'Mots d\'affirmation',
    'Temps de qualité',
    'Cadeaux',
    'Services rendus',
    'Contact physique',
  ];

  // ─── Personality Types (MBTI) ────────────────────────────────────────────────
  static const List<String> mbtiTypes = [
    'INTJ', 'INTP', 'ENTJ', 'ENTP',
    'INFJ', 'INFP', 'ENFJ', 'ENFP',
    'ISTJ', 'ISFJ', 'ESTJ', 'ESFJ',
    'ISTP', 'ISFP', 'ESTP', 'ESFP',
    'Introverti', 'Extraverti', 'Ambivert',
  ];

  // ─── Goal Statuses ───────────────────────────────────────────────────────────
  static const List<String> goalStatuses = [
    'en_cours',
    'complété',
    'en_pause',
    'abandonné',
  ];

  static const Map<String, String> goalStatusLabels = {
    'en_cours': 'En cours',
    'complété': 'Complété ✅',
    'en_pause': 'En pause ⏸',
    'abandonné': 'Abandonné',
  };

  // ─── Habit Preset Icons ──────────────────────────────────────────────────────
  static const List<String> habitIcons = [
    '💪', '🧘', '📚', '✍️', '🏃', '💧', '🌙', '☀️',
    '🥗', '🎵', '🎨', '💊', '📞', '🤝', '🧠', '❤️',
  ];

  // ─── Habit Preset Colors ─────────────────────────────────────────────────────
  static const List<int> habitColors = [
    0xFF6C63FF, // primary
    0xFFFF6584, // secondary
    0xFF43E97B, // accent
    0xFFFFD93D, // warning
    0xFF54A0FF, // info
    0xFFFF9F43, // orange
    0xFF00D2D3, // teal
    0xFFAA00FF, // purple
  ];
}
