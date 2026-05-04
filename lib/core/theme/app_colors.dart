import 'package:flutter/material.dart';

abstract class AppColors {
  // Primary palette
  static const Color primary = Color(0xFF6C63FF);       // Violet — introspection
  static const Color primaryLight = Color(0xFF8F88FF);
  static const Color primaryDark = Color(0xFF4A42D6);

  // Secondary palette
  static const Color secondary = Color(0xFFFF6584);     // Rose — émotions
  static const Color secondaryLight = Color(0xFFFF8FA3);
  static const Color secondaryDark = Color(0xFFD4455F);

  // Accent
  static const Color accent = Color(0xFF43E97B);        // Vert — progression
  static const Color accentLight = Color(0xFF6EEEA0);
  static const Color accentDark = Color(0xFF25C45A);

  // Backgrounds
  static const Color background = Color(0xFF0F0F1A);    // Bleu nuit profond
  static const Color surface = Color(0xFF1A1A2E);       // Carte principale
  static const Color surface2 = Color(0xFF16213E);      // Carte secondaire
  static const Color surface3 = Color(0xFF1F2B47);      // Carte tertiaire

  // Text
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF8892B0);
  static const Color textMuted = Color(0xFF4A5568);

  // Status colors
  static const Color warning = Color(0xFFFFD93D);
  static const Color error = Color(0xFFFF4757);
  static const Color success = Color(0xFF43E97B);
  static const Color info = Color(0xFF54A0FF);

  // Emotion colors
  static const Color emotionJoy = Color(0xFFFFD93D);
  static const Color emotionSadness = Color(0xFF54A0FF);
  static const Color emotionAnger = Color(0xFFFF4757);
  static const Color emotionFear = Color(0xFFAA00FF);
  static const Color emotionSurprise = Color(0xFFFF9F43);
  static const Color emotionDisgust = Color(0xFF00D2D3);
  static const Color emotionAnticipation = Color(0xFF43E97B);
  static const Color emotionTrust = Color(0xFF6C63FF);
  static const Color emotionNeutral = Color(0xFF8892B0);

  // Relation type colors
  static const Color relationFriend = Color(0xFF43E97B);
  static const Color relationFamily = Color(0xFFFF9F43);
  static const Color relationPartner = Color(0xFFFF6584);
  static const Color relationColleague = Color(0xFF54A0FF);
  static const Color relationMentor = Color(0xFF6C63FF);
  static const Color relationOther = Color(0xFF8892B0);

  // Gradient definitions
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6C63FF), Color(0xFF8F88FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [Color(0xFFFF6584), Color(0xFFFF8FA3)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFF43E97B), Color(0xFF38F9D7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [Color(0xFF0F0F1A), Color(0xFF16213E)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Divider
  static const Color divider = Color(0xFF2D3561);

  // Overlay
  static const Color overlay = Color(0x99000000);
}
