import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/context_entry.dart';

class ContextCard extends StatelessWidget {
  final ContextEntry entry;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const ContextCard({
    super.key,
    required this.entry,
    this.onTap,
    this.onDelete,
  });

  static const Map<String, Color> _categoryColors = {
    'travail': AppColors.info,
    'famille': AppColors.emotionSurprise,
    'santé': AppColors.accent,
    'rêve': AppColors.primary,
    'traumatisme': AppColors.error,
    'souvenir': AppColors.warning,
    'accomplissement': AppColors.accent,
    'difficulté': AppColors.secondary,
    'voyage': AppColors.emotionTrust,
    'autre': AppColors.textSecondary,
  };

  static const Map<String, String> _categoryIcons = {
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

  Color get _color => _categoryColors[entry.category] ?? AppColors.textSecondary;
  String get _icon => _categoryIcons[entry.category] ?? '📌';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface2,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.divider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Category badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: _color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_icon, style: const TextStyle(fontSize: 11)),
                      const SizedBox(width: 4),
                      Text(
                        entry.category,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: _color,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // Importance stars
                Row(
                  children: List.generate(
                    5,
                    (i) => Icon(
                      i < entry.importance
                          ? Icons.star_rounded
                          : Icons.star_outline_rounded,
                      size: 12,
                      color: i < entry.importance
                          ? AppColors.warning
                          : AppColors.textMuted,
                    ),
                  ),
                ),
                if (onDelete != null) ...[
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: onDelete,
                    child: const Icon(
                      Icons.close_rounded,
                      size: 14,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 8),
            Text(
              entry.title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              entry.description,
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.calendar_today_rounded,
                    size: 10, color: AppColors.textMuted),
                const SizedBox(width: 4),
                Text(
                  DateFormat('dd MMM yyyy', 'fr_FR').format(entry.date),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                if (entry.tags.isNotEmpty) ...[
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      entry.tags.map((t) => '#$t').join(' '),
                      style: TextStyle(
                        fontSize: 10,
                        color: _color.withValues(alpha: 0.7),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
