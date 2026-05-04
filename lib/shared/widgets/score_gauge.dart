import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';

class ScoreGauge extends StatelessWidget {
  final double score; // 0-100
  final String? label;
  final double size;
  final bool showDetails;

  const ScoreGauge({
    super.key,
    required this.score,
    this.label,
    this.size = 160,
    this.showDetails = false,
  });

  Color get _color {
    if (score >= 80) return AppColors.accent;
    if (score >= 60) return AppColors.primary;
    if (score >= 40) return AppColors.warning;
    if (score >= 20) return AppColors.secondary;
    return AppColors.error;
  }

  IconData get _icon {
    if (score >= 80) return Icons.auto_awesome_rounded;
    if (score >= 60) return Icons.favorite_rounded;
    if (score >= 40) return Icons.sentiment_satisfied_rounded;
    if (score >= 20) return Icons.sentiment_neutral_rounded;
    return Icons.sentiment_very_dissatisfied_rounded;
  }

  String get _statusLabel {
    if (score >= 80) return 'Excellente';
    if (score >= 60) return 'Bonne';
    if (score >= 40) return 'Moyenne';
    if (score >= 20) return 'Fragile';
    return 'Critique';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Animate(
          effects: [
            FadeEffect(duration: 600.ms),
            ScaleEffect(
              begin: const Offset(0.8, 0.8),
              end: const Offset(1.0, 1.0),
              duration: 600.ms,
              curve: Curves.elasticOut,
            ),
          ],
          child: SizedBox(
            width: size,
            height: size * 0.85, // Increased from 0.7 to prevent overflow
            child: CustomPaint(
              painter: _GaugePainter(
                progress: score / 100,
                color: _color,
              ),
              child: Align(
                alignment: const Alignment(0, 0.6), // Adjusted alignment
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(_icon, size: size * 0.18, color: _color),
                    const SizedBox(height: 2),
                    Text(
                      '${score.toInt()}',
                      style: TextStyle(
                        fontSize: size * 0.22,
                        fontWeight: FontWeight.w800,
                        color: _color,
                      ),
                    ),
                    Text(
                      _statusLabel,
                      style: TextStyle(
                        fontSize: size * 0.1,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (label != null) ...[
          const SizedBox(height: 4),
          Text(
            label!,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ],
    );
  }
}

class _GaugePainter extends CustomPainter {
  final double progress;
  final Color color;

  _GaugePainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.75); // Moved up
    final radius = size.width / 2 - 10;
    const strokeWidth = 12.0;

    // Background arc
    final bgPaint = Paint()
      ..color = color.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      math.pi,
      false,
      bgPaint,
    );

    // Track ticks
    final tickPaint = Paint()
      ..color = AppColors.divider
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (int i = 0; i <= 10; i++) {
      final angle = math.pi + (math.pi * i / 10);
      final innerR = radius - 6;
      final outerR = radius + 6;
      canvas.drawLine(
        Offset(center.dx + innerR * math.cos(angle),
            center.dy + innerR * math.sin(angle)),
        Offset(center.dx + outerR * math.cos(angle),
            center.dy + outerR * math.sin(angle)),
        tickPaint,
      );
    }

    // Progress arc
    final fgPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      math.pi * progress,
      false,
      fgPaint,
    );

    // Needle tip
    if (progress > 0) {
      final tipAngle = math.pi + (math.pi * progress);
      final tipX = center.dx + radius * math.cos(tipAngle);
      final tipY = center.dy + radius * math.sin(tipAngle);
      final tipPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(tipX, tipY), 6, tipPaint);
      canvas.drawCircle(
          Offset(tipX, tipY),
          5,
          tipPaint
            ..color = color
            ..style = PaintingStyle.fill);
    }
  }

  @override
  bool shouldRepaint(_GaugePainter old) => old.progress != progress;
}
