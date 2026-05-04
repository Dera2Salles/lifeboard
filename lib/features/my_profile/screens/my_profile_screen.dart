import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/radar_chart_widget.dart';
import '../../../shared/widgets/insight_card.dart';
import '../../../shared/providers/user_provider.dart';
import '../../../data/models/user.dart';

class MyProfileScreen extends ConsumerWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider);

    return Scaffold(
      body: SafeArea(
        child: userAsync.when(
          loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
          error: (e, _) => Center(child: Text('Erreur: $e')),
          data: (user) => LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 700;
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: _buildHeader(context, user)),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: isWide
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 3, child: _buildRadar(context, user)),
                              const SizedBox(width: 24),
                              Expanded(flex: 2, child: _buildPersonalitySection(context, user, ref)),
                            ],
                          )
                        : Column(
                            children: [
                              _buildRadar(context, user),
                              _buildPersonalitySection(context, user, ref),
                            ],
                          ),
                    ),
                  ),
                  SliverToBoxAdapter(child: _buildGoalsSection(context, user, ref)),
                  SliverToBoxAdapter(child: _buildHighlightsSection(context, user, ref)),
                  const SliverToBoxAdapter(child: SizedBox(height: 80)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, user) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Mon Profil', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.explore_outlined, size: 16, color: AppColors.textSecondary),
              const SizedBox(width: 6),
              Text('Ta boussole intérieure', style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ])),
        Container(
          width: 64, height: 64,
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.2), blurRadius: 16, offset: const Offset(0, 4))],
          ),
          child: const Center(child: Icon(Icons.psychology_rounded, color: Colors.white, size: 32)),
        ),
      ]).animate().fadeIn(duration: 300.ms),
    );
  }

  Widget _buildRadar(BuildContext context, user) {
    final Map<String, double> radarData = {};
    for (int i = 0; i < user.radarLabels.length; i++) {
      radarData[user.radarLabels[i]] = user.radarValues[i];
    }

    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.divider),
        ),
        child: RadarChartWidget(data: radarData, title: 'Mes Forces', color: AppColors.primary),
      ).animate().fadeIn(duration: 400.ms, delay: 100.ms),
    );
  }

  Widget _buildPersonalitySection(BuildContext context, user, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Personnalité & Amour', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 16),
        _SectionCard(
          icon: Icons.psychology_outlined,
          label: 'Type de personnalité',
          child: Wrap(
            spacing: 8, runSpacing: 8,
            children: ['INFP', 'ENFJ', 'INTJ', 'Ambivert', 'Introverti', 'Extraverti'].map((t) => GestureDetector(
              onTap: () {
                user.personalityType = t;
                ref.read(userUpdateProvider.notifier).saveUser(user);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: user.personalityType == t ? AppColors.primary.withValues(alpha: 0.15) : AppColors.surface2,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: user.personalityType == t ? AppColors.primary : AppColors.divider),
                ),
                child: Text(t, style: TextStyle(fontSize: 12, color: user.personalityType == t ? AppColors.primary : AppColors.textSecondary, fontWeight: user.personalityType == t ? FontWeight.w700 : FontWeight.w400)),
              ),
            )).toList(),
          ),
        ),
        const SizedBox(height: 16),
        _SectionCard(
          icon: Icons.favorite_border_rounded,
          label: 'Mon langage d\'amour',
          child: Column(
            children: ['Paroles valorisantes', 'Moments de qualité', 'Cadeaux', 'Services rendus', 'Toucher physique'].map((l) => GestureDetector(
              onTap: () {
                user.loveLanguage = l;
                ref.read(userUpdateProvider.notifier).saveUser(user);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: user.loveLanguage == l ? AppColors.secondary.withValues(alpha: 0.1) : AppColors.surface2,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: user.loveLanguage == l ? AppColors.secondary : AppColors.divider),
                ),
                child: Row(children: [
                  Text(l, style: TextStyle(fontSize: 13, color: user.loveLanguage == l ? AppColors.secondary : AppColors.textSecondary, fontWeight: user.loveLanguage == l ? FontWeight.w600 : FontWeight.w400)),
                  const Spacer(),
                  if (user.loveLanguage == l) const Icon(Icons.check_circle_rounded, size: 16, color: AppColors.secondary),
                ]),
              ),
            )).toList(),
          ),
        ),
      ]).animate().fadeIn(duration: 400.ms, delay: 150.ms),
    );
  }

  Widget _buildGoalsSection(BuildContext context, User user, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text('Mes Objectifs', style: Theme.of(context).textTheme.titleMedium),
          const Spacer(),
          TextButton.icon(
            onPressed: () => _showAddItemDialog(context, 'Objectif', user.goals, (newList) {
              user.goals = newList;
              ref.read(userUpdateProvider.notifier).saveUser(user);
            }),
            icon: const Icon(Icons.add, size: 14),
            label: const Text('Ajouter'),
          ),
        ]),
        const SizedBox(height: 12),
        if (user.goals.isEmpty)
          const Center(child: Padding(padding: EdgeInsets.all(20), child: Text('Aucun objectif défini', style: TextStyle(fontStyle: FontStyle.italic, fontSize: 13)))),
        ...user.goals.asMap().entries.map((e) {
          final g = e.value;
          final progress = 0.3 + (e.key * 0.15); // Simulated progress
          final color = e.key % 3 == 0 ? AppColors.primary : (e.key % 3 == 1 ? AppColors.accent : AppColors.secondary);
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Dismissible(
              key: Key('goal_$g'),
              onDismissed: (_) {
                user.goals.remove(g);
                ref.read(userUpdateProvider.notifier).saveUser(user);
              },
              background: Container(color: Colors.red, alignment: Alignment.centerRight, padding: const EdgeInsets.only(right: 20), child: const Icon(Icons.delete, color: Colors.white)),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.divider)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Expanded(child: Text(g, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600, color: AppColors.textPrimary))),
                    Text('${(progress * 100).toInt()}%', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: color)),
                  ]),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(value: progress, minHeight: 6, backgroundColor: color.withValues(alpha: 0.1), valueColor: AlwaysStoppedAnimation<Color>(color)),
                  ),
                ]),
              ),
            ),
          );
        }),
      ]).animate().fadeIn(duration: 400.ms, delay: 200.ms),
    );
  }

  Widget _buildHighlightsSection(BuildContext context, User user, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text('À retenir sur moi', style: Theme.of(context).textTheme.titleMedium),
          const Spacer(),
          TextButton.icon(
            onPressed: () => _showAddItemDialog(context, 'Highlight', user.highlights, (newList) {
              user.highlights = newList;
              ref.read(userUpdateProvider.notifier).saveUser(user);
            }),
            icon: const Icon(Icons.add, size: 14),
            label: const Text('Ajouter'),
          ),
        ]),
        const SizedBox(height: 12),
        ...user.highlights.asMap().entries.map((e) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Dismissible(
            key: Key('highlight_${e.value}'),
            onDismissed: (_) {
              user.highlights.removeAt(e.key);
              ref.read(userUpdateProvider.notifier).saveUser(user);
            },
            child: InsightCard(
              icon: e.key % 2 == 0 ? Icons.eco_rounded : Icons.track_changes_rounded,
              title: e.key % 2 == 0 ? 'Croissance' : 'Focus',
              body: e.value,
              color: e.key % 2 == 0 ? AppColors.accent : AppColors.primary,
            ),
          ),
        )),
      ]).animate().fadeIn(duration: 400.ms, delay: 250.ms),
    );
  }

  void _showAddItemDialog(BuildContext context, String title, List<String> items, Function(List<String>) onChanged) {
    final controller = TextEditingController();
    showDialog(context: context, builder: (ctx) => AlertDialog(
      title: Text('Ajouter : $title'),
      content: TextField(controller: controller, autofocus: true, decoration: InputDecoration(hintText: 'Saisir un $title...')),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Annuler')),
        TextButton(onPressed: () {
          if (controller.text.isNotEmpty) {
            onChanged(List<String>.from(items)..add(controller.text));
          }
          Navigator.pop(ctx);
        }, child: const Text('Ajouter')),
      ],
    ));
  }
}

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget child;
  const _SectionCard({required this.icon, required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.divider)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Icon(icon, size: 18, color: AppColors.primary),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
        ]),
        const SizedBox(height: 16),
        child,
      ]),
    );
  }
}
