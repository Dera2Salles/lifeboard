import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../providers/persons_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/person.dart';
import '../../../data/models/profile.dart';
import '../../../data/models/emotion_log.dart';
import '../../../data/models/interaction.dart';
import '../../../data/models/context_entry.dart';
import '../../../data/models/relationship_score.dart';
import '../../../data/repositories/emotion_repository.dart';
import '../../../data/repositories/interaction_repository.dart';
import '../../../data/repositories/context_repository.dart';
import '../../../shared/widgets/radar_chart_widget.dart';
import '../../../shared/widgets/score_gauge.dart';
import '../../../shared/widgets/emotion_chip.dart';
import '../../../shared/widgets/relation_timeline.dart';
import '../../../shared/widgets/context_card.dart';

class PersonProfileScreen extends ConsumerStatefulWidget {
  final int personId;
  const PersonProfileScreen({super.key, required this.personId});

  @override
  ConsumerState<PersonProfileScreen> createState() => _PersonProfileScreenState();
}

class _PersonProfileScreenState extends ConsumerState<PersonProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    final personAsync = ref.watch(personDetailProvider(widget.personId));
    final scoreAsync = ref.watch(personScoreProvider(widget.personId));
    final profileAsync = ref.watch(personProfileProvider(widget.personId));

    return personAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator(color: AppColors.primary))),
      error: (e, _) => Scaffold(body: Center(child: Text('Erreur: $e'))),
      data: (person) {
        if (person == null) {
          return Scaffold(body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Text('😕', style: TextStyle(fontSize: 48)),
            TextButton(onPressed: () => context.pop(), child: const Text('Retour')),
          ])));
        }
        final color = _relationColor(person);
        return Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, _) => [
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                backgroundColor: AppColors.background,
                leading: IconButton(icon: const Icon(Icons.arrow_back_ios_rounded), onPressed: () => context.pop()),
                actions: [IconButton(icon: const Icon(Icons.edit_rounded), onPressed: () {})],
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [color.withValues(alpha: 0.3), AppColors.background],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: SafeArea(
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                        const SizedBox(height: 40),
                        Container(
                          width: 80, height: 80,
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                            border: Border.all(color: color.withValues(alpha: 0.6), width: 2.5),
                          ),
                          child: Center(child: Text(person.avatarEmoji, style: const TextStyle(fontSize: 38))),
                        ),
                        const SizedBox(height: 10),
                        Text(person.name, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(color: color.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(20)),
                          child: Text(person.relationTypeLabel, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color)),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
            ],
            body: Column(children: [
              Container(
                color: AppColors.surface,
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  tabs: const [Tab(text: '🧠 Âme'), Tab(text: '📌 Contextes'), Tab(text: '💫 Émotions'), Tab(text: '💬 Interactions'), Tab(text: '📊 Relation')],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _SoulTab(profile: profileAsync),
                    _ContextsTab(personId: widget.personId),
                    _EmotionsTab(personId: widget.personId),
                    _InteractionsTab(personId: widget.personId),
                    _RelationTab(scoreAsync: scoreAsync),
                  ],
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}

// ── Soul Tab ─────────────────────────────────────────────────────────────────
class _SoulTab extends StatelessWidget {
  final AsyncValue<Profile?> profile;
  const _SoulTab({required this.profile});

  @override
  Widget build(BuildContext context) {
    return profile.when(
      loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
      error: (e, _) => Center(child: Text('$e')),
      data: (p) => ListView(
        padding: const EdgeInsets.all(20),
        children: [
          if (p != null && p.desires.isNotEmpty)
            RadarChartWidget(
              data: buildProfileRadarData(desires: p.desires, dreams: p.dreams, fears: p.fears, loves: p.loves, dislikes: p.dislikes, values: p.values),
              title: 'Profil Psychologique',
            ),
          const SizedBox(height: 20),
          _ProfileSection(title: '✨ Désirs', items: p?.desires ?? [], color: AppColors.primary, emptyHint: 'Que désire-t-il/elle ?'),
          _ProfileSection(title: '🌟 Rêves', items: p?.dreams ?? [], color: AppColors.warning, emptyHint: 'Ses grands rêves...'),
          _ProfileSection(title: '😨 Peurs', items: p?.fears ?? [], color: AppColors.secondary, emptyHint: 'Ce qui l\'effraie...'),
          _ProfileSection(title: '❤️ Il/Elle aime', items: p?.loves ?? [], color: AppColors.accent, emptyHint: 'Ses passions...'),
          _ProfileSection(title: '🚫 N\'aime pas', items: p?.dislikes ?? [], color: AppColors.error, emptyHint: 'Ce qu\'il/elle déteste...'),
          _ProfileSection(title: '🏛️ Valeurs', items: p?.values ?? [], color: AppColors.info, emptyHint: 'Ce qui est important...'),
          if (p?.loveLanguage != null) _InfoTile(icon: '💝', label: 'Langage d\'amour', value: p!.loveLanguage!),
          if (p?.personalityType != null) _InfoTile(icon: '🧠', label: 'Personnalité', value: p!.personalityType!),
          const SizedBox(height: 16),
          ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.edit_rounded, size: 16), label: const Text('Modifier le profil')),
        ],
      ),
    );
  }
}

class _ProfileSection extends StatelessWidget {
  final String title;
  final List<String> items;
  final Color color;
  final String emptyHint;
  const _ProfileSection({required this.title, required this.items, required this.color, required this.emptyHint});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          if (items.isEmpty)
            Text(emptyHint, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic))
          else
            Wrap(
              spacing: 6, runSpacing: 6,
              children: items.map((item) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(20), border: Border.all(color: color.withValues(alpha: 0.3))),
                child: Text(item, style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w500)),
              )).toList(),
            ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String icon, label, value;
  const _InfoTile({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: AppColors.surface2, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.divider)),
      child: Row(children: [
        Text(icon, style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 10),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: Theme.of(context).textTheme.labelSmall),
          Text(value, style: Theme.of(context).textTheme.bodyMedium),
        ]),
      ]),
    );
  }
}

// ── Contexts Tab ──────────────────────────────────────────────────────────────
class _ContextsTab extends StatelessWidget {
  final int personId;
  const _ContextsTab({required this.personId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ContextEntry>>(
      future: ContextRepository().getContextsForPerson(personId),
      builder: (context, snapshot) {
        final contexts = snapshot.data ?? [];
        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(children: [
              Text('${contexts.length} contextes', style: Theme.of(context).textTheme.bodyMedium),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add, size: 14),
                label: const Text('Ajouter'),
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
              ),
            ]),
            const SizedBox(height: 16),
            if (contexts.isEmpty)
              Center(child: Padding(padding: const EdgeInsets.all(32), child: Column(children: [
                const Text('📌', style: TextStyle(fontSize: 40)),
                const SizedBox(height: 8),
                Text('Aucun contexte', style: Theme.of(context).textTheme.bodyMedium),
              ])))
            else
              ...contexts.map((ctx) => Padding(padding: const EdgeInsets.only(bottom: 10), child: ContextCard(entry: ctx))),
          ],
        );
      },
    );
  }
}

// ── Emotions Tab ──────────────────────────────────────────────────────────────
class _EmotionsTab extends StatelessWidget {
  final int personId;
  const _EmotionsTab({required this.personId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<EmotionLog>>(
      future: EmotionRepository().getRecentEmotions(personId, limit: 50),
      builder: (context, snapshot) {
        final logs = snapshot.data ?? [];
        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            if (logs.isNotEmpty) ...[
              Text('Évolution', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 12),
              SizedBox(height: 140, child: _EmotionChart(logs: logs)),
              const SizedBox(height: 20),
            ],
            Row(children: [
              Text('Historique (${logs.length})', style: Theme.of(context).textTheme.titleSmall),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add, size: 14),
                label: const Text('Logger'),
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
              ),
            ]),
            const SizedBox(height: 12),
            if (logs.isEmpty)
              Center(child: Padding(padding: const EdgeInsets.all(32), child: Column(children: [
                const Text('💫', style: TextStyle(fontSize: 40)),
                const SizedBox(height: 8),
                Text('Aucune émotion enregistrée', style: Theme.of(context).textTheme.bodyMedium),
              ])))
            else
              ...logs.map((log) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(children: [
                  EmotionChip(emotion: log.emotion, intensity: log.intensity),
                  const SizedBox(width: 8),
                  Expanded(child: Text(log.note ?? log.context ?? '', style: Theme.of(context).textTheme.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis)),
                  Text(DateFormat('dd/MM', 'fr_FR').format(log.date), style: Theme.of(context).textTheme.bodySmall),
                ]),
              )),
          ],
        );
      },
    );
  }
}

class _EmotionChart extends StatelessWidget {
  final List<EmotionLog> logs;
  const _EmotionChart({required this.logs});

  @override
  Widget build(BuildContext context) {
    final spots = logs.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value.intensity.toDouble())).toList();
    return LineChart(LineChartData(
      gridData: const FlGridData(show: false),
      titlesData: const FlTitlesData(show: false),
      borderData: FlBorderData(show: false),
      minY: 1, maxY: 10,
      lineBarsData: [LineChartBarData(
        spots: spots,
        isCurved: true,
        color: AppColors.secondary,
        barWidth: 2.5,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: true, color: AppColors.secondary.withValues(alpha: 0.1)),
      )],
    ));
  }
}

// ── Interactions Tab ──────────────────────────────────────────────────────────
class _InteractionsTab extends StatelessWidget {
  final int personId;
  const _InteractionsTab({required this.personId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Interaction>>(
      future: InteractionRepository().getInteractionsForPerson(personId),
      builder: (context, snapshot) {
        final interactions = snapshot.data ?? [];
        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(children: [
              Text('${interactions.length} interactions', style: Theme.of(context).textTheme.bodyMedium),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add, size: 14),
                label: const Text('Ajouter'),
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
              ),
            ]),
            const SizedBox(height: 16),
            RelationTimeline(interactions: interactions),
          ],
        );
      },
    );
  }
}

// ── Relation Tab ──────────────────────────────────────────────────────────────
class _RelationTab extends StatelessWidget {
  final AsyncValue<RelationshipScore> scoreAsync;
  const _RelationTab({required this.scoreAsync});

  @override
  Widget build(BuildContext context) {
    return scoreAsync.when(
      loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
      error: (e, _) => Center(child: Text('$e')),
      data: (score) => ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(child: ScoreGauge(score: score.score, label: 'Score global', size: 180)),
          const SizedBox(height: 32),
          Text('Détail', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 16),
          _ScoreBar(label: '🔐 Confiance', value: score.trustLevel, color: AppColors.primary),
          const SizedBox(height: 12),
          _ScoreBar(label: '💬 Communication', value: score.communicationLevel, color: AppColors.accent),
          const SizedBox(height: 12),
          _ScoreBar(label: '🫀 Proximité émotionnelle', value: score.emotionalCloseness, color: AppColors.secondary),
          const SizedBox(height: 24),
          Text('Dernière évaluation : ${DateFormat('dd MMM yyyy', 'fr_FR').format(score.lastEvaluated)}',
            style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.center),
          const SizedBox(height: 20),
          ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.refresh_rounded, size: 16), label: const Text('Réévaluer')),
        ],
      ),
    );
  }
}

class _ScoreBar extends StatelessWidget {
  final String label;
  final double value;
  final Color color;
  const _ScoreBar({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          const Spacer(),
          Text('${value.toInt()}%', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: color)),
        ]),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(value: value / 100, minHeight: 8, backgroundColor: color.withValues(alpha: 0.15), valueColor: AlwaysStoppedAnimation<Color>(color)),
        ),
      ],
    );
  }
}
