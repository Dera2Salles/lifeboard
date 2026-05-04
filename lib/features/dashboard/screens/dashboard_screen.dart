import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../providers/dashboard_provider.dart';
import '../../habits/providers/habits_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/person_card.dart';
import '../../../shared/widgets/habit_ring.dart';
import '../../../shared/widgets/score_gauge.dart';
import '../../../shared/widgets/insight_card.dart';
import '../../../core/utils/icon_utils.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(dashboardProvider);
    final selectedMood = ref.watch(todayMoodProvider);

    return Scaffold(
      body: SafeArea(
        child: dashboardAsync.when(
          loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
          error: (e, _) => Center(child: Text('Erreur: $e')),
          data: (data) => LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 600;
              return CustomScrollView(
                slivers: [
                  // Header
                  SliverToBoxAdapter(
                    child: _buildHeader(context, data.greeting, selectedMood, ref),
                  ),
                  // Global score & Mood (Responsive layout)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                      child: isWide 
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: _buildGlobalScoreContent(context, data.globalScore)),
                              const SizedBox(width: 24),
                              Expanded(child: _buildMoodSelectorContent(context, selectedMood, ref)),
                            ],
                          )
                        : Column(
                            children: [
                              _buildGlobalScoreContent(context, data.globalScore),
                              const SizedBox(height: 24),
                              _buildMoodSelectorContent(context, selectedMood, ref),
                            ],
                          ),
                    ),
                  ),
                  // Today's habits
                  if (data.todayHabits.isNotEmpty)
                    SliverToBoxAdapter(
                      child: _buildHabitsSection(context, data, ref),
                    ),
                  // Recent persons
                  SliverToBoxAdapter(
                    child: _buildPersonsSection(context, data, ref),
                  ),
                  // Insights
                  SliverToBoxAdapter(
                    child: _buildInsights(context),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(
      BuildContext context, String greeting, String? mood, WidgetRef ref) {
    final now = DateTime.now();
    final dateStr = DateFormat('EEEE d MMMM', 'fr_FR').format(now);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  greeting,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1),
                const SizedBox(height: 2),
                Text(
                  dateStr,
                  style: Theme.of(context).textTheme.bodyMedium,
                ).animate().fadeIn(duration: 400.ms, delay: 100.ms),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => context.push('/my_profile'),
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4))
                ]
              ),
              child: const Center(
                child: Icon(Icons.person_rounded, color: Colors.white, size: 26),
              ),
            ),
          ).animate().fadeIn(duration: 400.ms, delay: 200.ms),
        ],
      ),
    );
  }

  Widget _buildGlobalScoreContent(BuildContext context, double score) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          ScoreGauge(score: score, size: 110),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Score de Vie',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Tes relations & habitudes',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 12),
                _MetricRow(
                  icon: Icons.people_rounded,
                  label: 'Relations',
                  color: AppColors.primary,
                ),
                const SizedBox(height: 6),
                _MetricRow(
                  icon: Icons.sync_rounded,
                  label: 'Habitudes',
                  color: AppColors.accent,
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms, delay: 150.ms);
  }

  Widget _buildMoodSelectorContent(
      BuildContext context, String? selectedMood, WidgetRef ref) {
    const moods = [
      ('Super', Icons.sentiment_very_satisfied_rounded),
      ('Bien', Icons.sentiment_satisfied_rounded),
      ('Ok', Icons.sentiment_neutral_rounded),
      ('Pas top', Icons.sentiment_dissatisfied_rounded),
      ('Mal', Icons.sentiment_very_dissatisfied_rounded),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Comment te sens-tu ?',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: moods
              .map(
                (m) => Expanded(
                  child: GestureDetector(
                    onTap: () =>
                        ref.read(todayMoodProvider.notifier).state = m.$1,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: selectedMood == m.$1
                            ? AppColors.primary.withValues(alpha: 0.15)
                            : AppColors.surface2,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: selectedMood == m.$1
                              ? AppColors.primary
                              : AppColors.divider,
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(m.$2, size: 24, color: selectedMood == m.$1 ? AppColors.primary : AppColors.textSecondary),
                          const SizedBox(height: 6),
                          Text(
                            m.$1,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: selectedMood == m.$1
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                              color: selectedMood == m.$1
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    ).animate().fadeIn(duration: 400.ms, delay: 200.ms);
  }

  Widget _buildHabitsSection(
      BuildContext context, DashboardData data, WidgetRef ref) {
    final total = data.todayHabits.length;
    final done = data.completedToday;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Habitudes du jour',
                  style: Theme.of(context).textTheme.titleMedium),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: done == total
                      ? AppColors.accent.withValues(alpha: 0.15)
                      : AppColors.surface2,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$done/$total',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: done == total
                        ? AppColors.accent
                        : AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 110,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: data.todayHabits.length,
              separatorBuilder: (context, index) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final habit = data.todayHabits[index];
                return HabitRing(
                  icon: IconUtils.getIconForCategory(habit.category),
                  title: habit.title,
                  progress: 0.5,
                  color: Color(habit.color),
                  streak: habit.streak,
                  size: 72,
                  onTap: () =>
                      ref.read(habitsProvider.notifier).toggleToday(habit.id),
                );
              },
            ),
          ),
        ],
      ).animate().fadeIn(duration: 400.ms, delay: 250.ms),
    );
  }

  Widget _buildPersonsSection(
      BuildContext context, DashboardData data, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Personnes récentes',
                  style: Theme.of(context).textTheme.titleMedium),
              const Spacer(),
              TextButton(
                onPressed: () => context.go('/persons'),
                child: const Text('Voir tout'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (data.recentPersons.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Column(
                  children: [
                    Icon(Icons.people_outline_rounded, size: 40, color: AppColors.textMuted),
                    const SizedBox(height: 12),
                    Text('Ajoute des personnes à ta vie',
                        style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () => context.push('/persons/add'),
                      icon: const Icon(Icons.add, size: 16),
                      label: const Text('Ajouter'),
                    ),
                  ],
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.recentPersons.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final person = data.recentPersons[index];
                return PersonCard(
                  person: person,
                  animationIndex: index,
                  onTap: () => context.push('/persons/${person.id}'),
                );
              },
            ),
        ],
      ).animate().fadeIn(duration: 400.ms, delay: 300.ms),
    );
  }

  Widget _buildInsights(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Insights', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          InsightCard(
            icon: Icons.lightbulb_outline_rounded,
            title: 'Consacre du temps à tes proches',
            body:
                'Tu n\'as pas eu d\'interaction avec certaines personnes depuis plus de 7 jours.',
            color: AppColors.primary,
          ),
          const SizedBox(height: 10),
          InsightCard(
            icon: Icons.local_fire_department_rounded,
            title: 'Ton streak continue !',
            body:
                'Continue comme ça — la régularité est la clé de la progression.',
            color: AppColors.accent,
          ),
        ],
      ).animate().fadeIn(duration: 400.ms, delay: 350.ms),
    );
  }
}

class _MetricRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _MetricRow({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
