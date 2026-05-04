import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class EmotionChip extends StatelessWidget {
  final String emotion;
  final int? intensity;
  final bool selected;
  final VoidCallback? onTap;
  final bool showIntensity;

  const EmotionChip({
    super.key,
    required this.emotion,
    this.intensity,
    this.selected = false,
    this.onTap,
    this.showIntensity = true,
  });

  static const Map<String, Color> _emotionColors = {
    'joie': AppColors.emotionJoy,
    'tristesse': AppColors.emotionSadness,
    'colère': AppColors.emotionAnger,
    'peur': AppColors.emotionFear,
    'surprise': AppColors.emotionSurprise,
    'dégoût': AppColors.emotionDisgust,
    'anticipation': AppColors.emotionAnticipation,
    'confiance': AppColors.emotionTrust,
    'neutre': AppColors.emotionNeutral,
  };

  static const Map<String, String> _emotionEmojis = {
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

  Color get _color => _emotionColors[emotion] ?? AppColors.emotionNeutral;
  String get _emoji => _emotionEmojis[emotion] ?? '😐';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: selected
              ? _color.withValues(alpha: 0.25)
              : _color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? _color : _color.withValues(alpha: 0.3),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_emoji, style: const TextStyle(fontSize: 14)),
            const SizedBox(width: 5),
            Text(
              emotion,
              style: TextStyle(
                fontSize: 12,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: _color,
              ),
            ),
            if (showIntensity && intensity != null) ...[
              const SizedBox(width: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                decoration: BoxDecoration(
                  color: _color.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$intensity',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: _color,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
