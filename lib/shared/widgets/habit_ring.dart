import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';

class HabitRing extends StatelessWidget {
  final IconData icon;
  final String title;
  final double progress; // 0.0 to 1.0
  final Color color;
  final bool completed;
  final int streak;
  final VoidCallback? onTap;
  final double size;

  const HabitRing({
    super.key,
    required this.icon,
    required this.title,
    required this.progress,
    required this.color,
    this.completed = false,
    this.streak = 0,
    this.onTap,
    this.size = 80,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Animate(
            effects: completed
                ? [
                    ScaleEffect(
                      begin: const Offset(0.9, 0.9),
                      end: const Offset(1.0, 1.0),
                      duration: 300.ms,
                      curve: Curves.elasticOut,
                    ),
                  ]
                : [],
            child: SizedBox(
              width: size,
              height: size,
              child: CustomPaint(
                painter: _HabitRingPainter(
                  progress: progress,
                  color: color,
                  completed: completed,
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        icon,
                        size: size * 0.35,
                        color: completed ? color : AppColors.textSecondary,
                      ),
                      if (streak > 0) ...[
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.local_fire_department_rounded, size: size * 0.15, color: AppColors.warning),
                            Text(
                              '$streak',
                              style: TextStyle(
                                fontSize: size * 0.13,
                                fontWeight: FontWeight.w700,
                                color: AppColors.warning,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: size,
            child: Text(
              title,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: completed
                        ? color
                        : AppColors.textSecondary,
                    fontWeight:
                        completed ? FontWeight.w700 : FontWeight.w400,
                  ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _HabitRingPainter extends CustomPainter {
  final double progress;
  final Color color;
  final bool completed;

  _HabitRingPainter({
    required this.progress,
    required this.color,
    required this.completed,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 6;
    const strokeWidth = 5.0;

    // Background ring
    final bgPaint = Paint()
      ..color = color.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, bgPaint);

    // Progress arc
    if (progress > 0) {
      final fgPaint = Paint()
        ..color = completed ? color : color.withValues(alpha: 0.8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2,
        2 * math.pi * progress,
        false,
        fgPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_HabitRingPainter old) =>
      old.progress != progress || old.completed != completed;
}
