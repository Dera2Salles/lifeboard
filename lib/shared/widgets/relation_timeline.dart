import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/interaction.dart';

class RelationTimeline extends StatelessWidget {
  final List<Interaction> interactions;
  final VoidCallback? onAddTap;

  const RelationTimeline({
    super.key,
    required this.interactions,
    this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    if (interactions.isEmpty) {
      return _EmptyTimeline(onAddTap: onAddTap);
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: interactions.length,
      itemBuilder: (context, index) {
        final interaction = interactions[index];
        final isLast = index == interactions.length - 1;
        return _TimelineItem(
          interaction: interaction,
          isLast: isLast,
        );
      },
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final Interaction interaction;
  final bool isLast;

  const _TimelineItem({required this.interaction, required this.isLast});

  Color get _qualityColor {
    if (interaction.qualityScore >= 8) return AppColors.accent;
    if (interaction.qualityScore >= 5) return AppColors.primary;
    if (interaction.qualityScore >= 3) return AppColors.warning;
    return AppColors.secondary;
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline line + dot
          SizedBox(
            width: 28,
            child: Column(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: _qualityColor.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                    border: Border.all(color: _qualityColor, width: 1.5),
                  ),
                  child: Center(
                    child: Text(
                      interaction.typeIcon,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 1.5,
                      color: AppColors.divider,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surface2,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.divider),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            interaction.type.toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: _qualityColor,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.star_rounded, size: 12, color: _qualityColor),
                            const SizedBox(width: 2),
                            Text(
                              '${interaction.qualityScore}/10',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: _qualityColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      interaction.summary,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                          DateFormat('dd MMM yyyy', 'fr_FR').format(interaction.date),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        if (interaction.lessonsLearned != null &&
                            interaction.lessonsLearned!.isNotEmpty) ...[
                          const SizedBox(width: 8),
                          const Text('💡', style: TextStyle(fontSize: 11)),
                          const SizedBox(width: 2),
                          Expanded(
                            child: Text(
                              interaction.lessonsLearned!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontStyle: FontStyle.italic,
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
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyTimeline extends StatelessWidget {
  final VoidCallback? onAddTap;
  const _EmptyTimeline({this.onAddTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Column(
          children: [
            const Text('📅', style: TextStyle(fontSize: 40)),
            const SizedBox(height: 12),
            Text(
              'Aucune interaction enregistrée',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            if (onAddTap != null)
              TextButton.icon(
                onPressed: onAddTap,
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Ajouter une interaction'),
              ),
          ],
        ),
      ),
    );
  }
}
