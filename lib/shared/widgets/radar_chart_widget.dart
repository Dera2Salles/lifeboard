import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/theme/app_colors.dart';

class RadarChartWidget extends StatelessWidget {
  final Map<String, double> data; // label → value (0-1)
  final Color? color;
  final String title;

  const RadarChartWidget({
    super.key,
    required this.data,
    this.color,
    this.title = 'Profil',
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return _EmptyRadar(title: title);
    }

    final chartColor = color ?? AppColors.primary;
    final entries = data.entries.toList();

    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        AspectRatio(
          aspectRatio: 1.2,
          child: RadarChart(
            RadarChartData(
              dataSets: [
                RadarDataSet(
                  fillColor: chartColor.withValues(alpha: 0.15),
                  borderColor: chartColor,
                  borderWidth: 2,
                  entryRadius: 4,
                  dataEntries: entries
                      .map((e) => RadarEntry(value: (e.value * 5).clamp(0, 5)))
                      .toList(),
                ),
              ],
              radarBackgroundColor: Colors.transparent,
              borderData: FlBorderData(show: false),
              radarBorderData: const BorderSide(
                color: AppColors.divider,
                width: 1,
              ),
              gridBorderData: const BorderSide(
                color: AppColors.divider,
                width: 0.5,
              ),
              tickBorderData: const BorderSide(
                color: AppColors.divider,
                width: 0.5,
              ),
              tickCount: 5,
              ticksTextStyle: const TextStyle(
                color: Colors.transparent,
                fontSize: 0,
              ),
              getTitle: (index, angle) {
                final label = entries[index].key;
                return RadarChartTitle(
                  text: label,
                  angle: angle,
                  positionPercentageOffset: 0.1,
                );
              },
              titleTextStyle: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
              titlePositionPercentageOffset: 0.15,
            ),
          ),
        ),
      ],
    );
  }
}

/// Construit un RadarChart depuis les listes du profil
Map<String, double> buildProfileRadarData({
  required List<String> desires,
  required List<String> dreams,
  required List<String> fears,
  required List<String> loves,
  required List<String> dislikes,
  required List<String> values,
}) {
  double norm(int count) => (count / 5).clamp(0.0, 1.0);
  return {
    'Désirs': norm(desires.length),
    'Rêves': norm(dreams.length),
    'Peurs': norm(fears.length),
    'Amours': norm(loves.length),
    'Aversions': norm(dislikes.length),
    'Valeurs': norm(values.length),
  };
}

class _EmptyRadar extends StatelessWidget {
  final String title;
  const _EmptyRadar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.2,
      child: CustomPaint(
        painter: _EmptyRadarPainter(),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🧠', style: TextStyle(fontSize: 32)),
              const SizedBox(height: 8),
              Text(
                'Profil vide\nAjoute des informations',
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyRadarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = AppColors.divider
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (int i = 1; i <= 4; i++) {
      canvas.drawCircle(center, size.width / 2 * i / 4, paint);
    }

    for (int i = 0; i < 6; i++) {
      final angle = 2 * math.pi * i / 6 - math.pi / 2;
      canvas.drawLine(
        center,
        Offset(
          center.dx + size.width / 2 * math.cos(angle),
          center.dy + size.height / 2 * math.sin(angle),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_EmptyRadarPainter old) => false;
}
