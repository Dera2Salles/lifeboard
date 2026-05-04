import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/person.dart';
import '../../data/models/relationship_score.dart';
import '../../core/utils/icon_utils.dart';

class PersonCard extends StatelessWidget {
  final Person person;
  final RelationshipScore? score;
  final String? lastInteraction;
  final VoidCallback? onTap;
  final int animationIndex;

  const PersonCard({
    super.key,
    required this.person,
    this.score,
    this.lastInteraction,
    this.onTap,
    this.animationIndex = 0,
  });

  Color get _relationColor {
    switch (person.relationType) {
      case RelationType.ami:
        return AppColors.relationFriend;
      case RelationType.famille:
        return AppColors.relationFamily;
      case RelationType.partenaire:
        return AppColors.relationPartner;
      case RelationType.collegue:
        return AppColors.relationColleague;
      case RelationType.mentor:
        return AppColors.relationMentor;
      case RelationType.connaissance:
      case RelationType.autre:
        return AppColors.relationOther;
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = score?.score ?? 50;

    return Animate(
      effects: [
        FadeEffect(duration: 300.ms, delay: (animationIndex * 60).ms),
        SlideEffect(
          begin: const Offset(0, 0.1),
          end: Offset.zero,
          duration: 300.ms,
          delay: (animationIndex * 60).ms,
        ),
      ],
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.divider),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: Container(width: 4, color: _relationColor),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 14, 14),
                  child: Row(
                    children: [
                      // Avatar Icon
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: _relationColor.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            IconUtils.getIconForRelation(person.relationType.name),
                            size: 26,
                            color: _relationColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      // Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              person.name,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 3),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _relationColor.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    person.relationTypeLabel,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: _relationColor,
                                    ),
                                  ),
                                ),
                                if (lastInteraction != null) ...[
                                  const SizedBox(width: 6),
                                  Text(
                                    '· $lastInteraction',
                                    style: Theme.of(context).textTheme.bodySmall,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Score
                      Column(
                        children: [
                          _ScoreRing(score: s, color: _relationColor),
                          const SizedBox(height: 4),
                          Text(
                            '${s.toInt()}',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: _relationColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ScoreRing extends StatelessWidget {
  final double score;
  final Color color;

  const _ScoreRing({required this.score, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 38,
      height: 38,
      child: CustomPaint(
        painter: _RingPainter(
          progress: score / 100,
          color: color,
          backgroundColor: color.withValues(alpha: 0.1),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color backgroundColor;

  _RingPainter({
    required this.progress,
    required this.color,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 3;
    const strokeWidth = 3.5;

    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final fgPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -1.5707963, // -pi/2 = top
      2 * 3.14159265 * progress,
      false,
      fgPaint,
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) => old.progress != progress;
}
