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
          data: (data) => CustomScrollView(
            slivers: [
              // Header
              SliverToBoxAdapter(
                child: _buildHeader(context, data.greeting, selectedMood, ref),
              ),
              // Global score
              SliverToBoxAdapter(
                child: _buildGlobalScore(context, data.globalScore),
              ),
              // Mood selector
              SliverToBoxAdapter(
                child: _buildMoodSelector(context, selectedMood, ref),
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
            onTap: () => {},
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text('🧬', style: TextStyle(fontSize: 22)),
              ),
            ),
          ).animate().fadeIn(duration: 400.ms, delay: 200.ms),
        ],
      ),
    );
  }

  Widget _buildGlobalScore(BuildContext context, double score) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary.withValues(alpha: 0.15),
              AppColors.surface,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            ScoreGauge(score: score, size: 120),
            const SizedBox(width: 20),
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
                    'Basé sur tes relations et habitudes',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 16),
                  _MetricRow(
                    emoji: '👥',
                    label: 'Relations',
                    color: AppColors.primary,
                  ),
                  const SizedBox(height: 6),
                  _MetricRow(
                    emoji: '🔄',
                    label: 'Habitudes',
                    color: AppColors.accent,
                  ),
                ],
              ),
            ),
          ],
        ),
      ).animate().fadeIn(duration: 500.ms, delay: 150.ms),
    );
  }

  Widget _buildMoodSelector(
      BuildContext context, String? selectedMood, WidgetRef ref) {
    const moods = [
      ('😄', 'Super'),
      ('🙂', 'Bien'),
      ('😐', 'Ok'),
      ('😔', 'Pas top'),
      ('😞', 'Mal'),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Comment tu te sens ?',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: moods
                .map(
                  (m) => GestureDetector(
                    onTap: () =>
                        ref.read(todayMoodProvider.notifier).state = m.$2,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: selectedMood == m.$2
                            ? AppColors.primary.withValues(alpha: 0.2)
                            : AppColors.surface2,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: selectedMood == m.$2
                              ? AppColors.primary
                              : AppColors.divider,
                          width: selectedMood == m.$2 ? 1.5 : 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(m.$1,
                              style: const TextStyle(fontSize: 24)),
                          const SizedBox(height: 4),
                          Text(
                            m.$2,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: selectedMood == m.$2
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                              color: selectedMood == m.$2
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms, delay: 200.ms);
  }

  Widget _buildHabitsSection(
      BuildContext context, DashboardData data, WidgetRef ref) {
    final total = data.todayHabits.length;
    final done = data.completedToday;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
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
                      ? AppColors.accent.withValues(alpha: 0.2)
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
                  icon: habit.icon,
                  title: habit.title,
                  progress: 0.5, // Simplified — would use actual log
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
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
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
                    const Text('👥', style: TextStyle(fontSize: 36)),
                    const SizedBox(height: 8),
                    Text('Ajoute des personnes à ta vie',
                        style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 12),
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
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Insights', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          InsightCard(
            emoji: '💡',
            title: 'Consacre du temps à tes proches',
            body:
                'Tu n\'as pas eu d\'interaction avec certaines personnes depuis plus de 7 jours.',
            color: AppColors.primary,
          ),
          const SizedBox(height: 10),
          InsightCard(
            emoji: '🔥',
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
  final String emoji;
  final String label;
  final Color color;

  const _MetricRow({
    required this.emoji,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 13)),
        const SizedBox(width: 6),
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
