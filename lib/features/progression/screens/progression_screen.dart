import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../persons/providers/persons_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/person.dart';
import '../../../data/repositories/person_repository.dart';
import '../../../shared/widgets/insight_card.dart';
import '../../../core/utils/icon_utils.dart';

class ProgressionScreen extends ConsumerWidget {
  const ProgressionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personsAsync = ref.watch(personsProvider);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Text('Progression', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800)).animate().fadeIn(duration: 300.ms),
              ),
            ),
            SliverToBoxAdapter(
              child: personsAsync.when(
                loading: () => const Padding(padding: EdgeInsets.all(40), child: Center(child: CircularProgressIndicator(color: AppColors.primary))),
                error: (e, _) => Center(child: Text('Erreur: $e')),
                data: (persons) => persons.isEmpty
                    ? _EmptyProgression(onAddPerson: () => context.push('/persons/add'))
                    : Column(children: [
                        _buildRelationScoresSection(context, persons),
                        _buildInteractionHeatmap(context),
                        _buildInsightsSection(context),
                        const SizedBox(height: 80),
                      ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRelationScoresSection(BuildContext context, List<Person> persons) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Scores de relations', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 16),
          ...persons.take(5).map((person) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: FutureBuilder(
              future: PersonRepository().getOrCreateScore(person.id),
              builder: (context, snapshot) {
                final score = snapshot.data?.score ?? 50;
                final color = _relationColor(person);
                return GestureDetector(
                  onTap: () => context.push('/persons/${person.id}'),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.divider),
                    ),
                    child: Row(children: [
                      Container(
                        width: 44, height: 44,
                        decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
                        child: Center(child: Icon(IconUtils.getIconForRelation(person.relationType.name), color: color, size: 22)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(person.name, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: score / 100, minHeight: 6,
                            backgroundColor: color.withValues(alpha: 0.1),
                            valueColor: AlwaysStoppedAnimation<Color>(color),
                          ),
                        ),
                      ])),
                      const SizedBox(width: 12),
                      Text('${score.toInt()}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: color)),
                    ]),
                  ).animate().fadeIn(duration: 300.ms).slideX(begin: 0.05),
                );
              },
            ),
          )),
        ],
      ),
    );
  }

  Color _relationColor(Person person) {
    switch (person.relationType) {
      case RelationType.ami: return AppColors.relationFriend;
      case RelationType.famille: return AppColors.relationFamily;
      case RelationType.partenaire: return AppColors.relationPartner;
      case RelationType.collegue: return AppColors.relationColleague;
      case RelationType.mentor: return AppColors.relationMentor;
      default: return AppColors.relationOther;
    }
  }

  Widget _buildInteractionHeatmap(BuildContext context) {
    final now = DateTime.now();
    final weeks = List.generate(12, (wi) {
      return List.generate(7, (di) {
        final d = now.subtract(Duration(days: (11 - wi) * 7 + (6 - di)));
        return d;
      });
    });

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Activité (12 semaines)', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 14),
          Row(
            children: weeks.map((week) => Expanded(
              child: Column(
                children: week.map((day) {
                  // Simulated activity level 0-3
                  final level = (day.day + day.month) % 4;
                  return Container(
                    margin: const EdgeInsets.all(1.5),
                    width: double.infinity, height: 12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: level == 0
                          ? AppColors.surface2
                          : AppColors.primary.withValues(alpha: 0.2 + level * 0.25),
                    ),
                  );
                }).toList(),
              ),
            )).toList(),
          ),
          const SizedBox(height: 8),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            const Text('Moins', style: TextStyle(fontSize: 10, color: AppColors.textMuted)),
            const SizedBox(width: 4),
            ...List.generate(4, (i) => Container(
              margin: const EdgeInsets.only(left: 3),
              width: 10, height: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: i == 0 ? AppColors.surface2 : AppColors.primary.withValues(alpha: 0.2 + i * 0.25),
              ),
            )),
            const SizedBox(width: 4),
            const Text('Plus', style: TextStyle(fontSize: 10, color: AppColors.textMuted)),
          ]),
        ],
      ).animate().fadeIn(duration: 400.ms, delay: 200.ms),
    );
  }

  Widget _buildInsightsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Insights', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 14),
          InsightCard(icon: Icons.analytics_outlined, title: 'Analyse de tes relations', body: 'Continue d\'enrichir tes profils pour obtenir des insights personnalisés.', color: AppColors.primary),
          const SizedBox(height: 10),
          InsightCard(icon: Icons.local_fire_department_rounded, title: 'Maintiens tes habitudes', body: 'La régularité construit de grandes choses. Continue chaque jour.', color: AppColors.accent),
          const SizedBox(height: 10),
          InsightCard(icon: Icons.chat_bubble_outline_rounded, title: 'Prends des nouvelles', body: 'Certaines personnes n\'ont pas eu d\'interactions récentes.', color: AppColors.secondary),
        ],
      ).animate().fadeIn(duration: 400.ms, delay: 300.ms),
    );
  }
}

class _EmptyProgression extends StatelessWidget {
  final VoidCallback onAddPerson;
  const _EmptyProgression({required this.onAddPerson});

  @override
  Widget build(BuildContext context) {
    return Center(child: Padding(
      padding: const EdgeInsets.all(40),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.analytics_outlined, size: 56, color: AppColors.textMuted),
        const SizedBox(height: 16),
        Text('Aucune donnée', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text('Ajoute des personnes et des interactions\npour voir ta progression', style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
        const SizedBox(height: 24),
        ElevatedButton.icon(onPressed: onAddPerson, icon: const Icon(Icons.person_add_rounded), label: const Text('Ajouter quelqu\'un')),
      ]),
    ));
  }
}
