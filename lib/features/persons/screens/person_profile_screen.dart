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
import '../../../shared/widgets/radar_chart_widget.dart';
import '../../../shared/widgets/score_gauge.dart';
import '../../../shared/widgets/emotion_chip.dart';
import '../../../shared/widgets/relation_timeline.dart';
import '../../../shared/widgets/context_card.dart';
import '../../../core/utils/icon_utils.dart';

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
            const Icon(Icons.person_off_rounded, size: 64, color: AppColors.textMuted),
            const SizedBox(height: 16),
            Text('Personne introuvable', style: Theme.of(context).textTheme.titleMedium),
            TextButton(onPressed: () => context.pop(), child: const Text('Retour')),
          ])));
        }
        final color = _relationColor(person);
        return Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, _) => [
              SliverAppBar(
                expandedHeight: 220,
                pinned: true,
                backgroundColor: AppColors.background,
                leading: IconButton(icon: const Icon(Icons.arrow_back_ios_rounded, size: 20), onPressed: () => context.pop()),
                actions: [IconButton(icon: const Icon(Icons.edit_rounded, size: 20), onPressed: () {})],
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    color: AppColors.background,
                    child: SafeArea(
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                        const SizedBox(height: 20),
                        Container(
                          width: 80, height: 80,
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                            border: Border.all(color: color.withValues(alpha: 0.4), width: 2),
                          ),
                          child: Center(
                            child: Icon(
                              IconUtils.getIconForRelation(person.relationType.name),
                              size: 40,
                              color: color,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(person.name, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
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
                  indicatorColor: AppColors.primary,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: const [
                    Tab(child: Row(children: [Icon(Icons.psychology_outlined, size: 16), SizedBox(width: 6), Text('Âme')])),
                    Tab(child: Row(children: [Icon(Icons.push_pin_outlined, size: 16), SizedBox(width: 6), Text('Contextes')])),
                    Tab(child: Row(children: [Icon(Icons.auto_awesome_outlined, size: 16), SizedBox(width: 6), Text('Émotions')])),
                    Tab(child: Row(children: [Icon(Icons.chat_bubble_outline_rounded, size: 16), SizedBox(width: 6), Text('Interactions')])),
                    Tab(child: Row(children: [Icon(Icons.analytics_outlined, size: 16), SizedBox(width: 6), Text('Relation')])),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _SoulTab(personId: widget.personId, profile: profileAsync),
                    _ContextsTab(personId: widget.personId),
                    _EmotionsTab(personId: widget.personId),
                    _InteractionsTab(personId: widget.personId),
                    _RelationTab(personId: widget.personId, scoreAsync: scoreAsync),
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
class _SoulTab extends ConsumerWidget {
  final int personId;
  final AsyncValue<Profile?> profile;
  const _SoulTab({required this.personId, required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return profile.when(
      loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
      error: (e, _) => Center(child: Text('$e')),
      data: (p) => ListView(
        padding: const EdgeInsets.all(20),
        children: [
          if (p != null)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.divider),
              ),
              child: RadarChartWidget(
                data: buildProfileRadarData(desires: p.desires, dreams: p.dreams, fears: p.fears, loves: p.loves, dislikes: p.dislikes, values: p.values),
                title: 'Profil Psychologique',
              ),
            ),
          const SizedBox(height: 24),
          _ProfileSection(icon: Icons.auto_fix_high_rounded, title: 'Désirs', items: p?.desires ?? [], color: AppColors.primary, emptyHint: 'Que désire-t-il/elle ?'),
          _ProfileSection(icon: Icons.star_outline_rounded, title: 'Rêves', items: p?.dreams ?? [], color: AppColors.warning, emptyHint: 'Ses grands rêves...'),
          _ProfileSection(icon: Icons.warning_amber_rounded, title: 'Peurs', items: p?.fears ?? [], color: AppColors.secondary, emptyHint: 'Ce qui l\'effraie...'),
          _ProfileSection(icon: Icons.favorite_border_rounded, title: 'Il/Elle aime', items: p?.loves ?? [], color: AppColors.accent, emptyHint: 'Ses passions...'),
          _ProfileSection(icon: Icons.block_flipped, title: 'N\'aime pas', items: p?.dislikes ?? [], color: AppColors.error, emptyHint: 'Ce qu\'il/elle déteste...'),
          _ProfileSection(icon: Icons.account_balance_outlined, title: 'Valeurs', items: p?.values ?? [], color: AppColors.info, emptyHint: 'Ce qui est important...'),
          
          if (p?.loveLanguage != null) _InfoTile(icon: Icons.favorite_rounded, label: 'Langage d\'amour', value: p!.loveLanguage!, color: AppColors.secondary),
          if (p?.personalityType != null) _InfoTile(icon: Icons.psychology_rounded, label: 'Personnalité', value: p!.personalityType!, color: AppColors.primary),
          
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () => _showEditProfileSheet(context, ref, personId, p),
            icon: const Icon(Icons.edit_rounded, size: 16),
            label: const Text('Modifier le profil'),
          ),
        ],
      ),
    );
  }

  void _showEditProfileSheet(BuildContext context, WidgetRef ref, int personId, Profile? profile) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => _EditProfileSheet(
        personId: personId,
        profile: profile,
        onSave: (p) async {
          await ref.read(personProfileProvider(personId).notifier).saveProfile(p);
          if (context.mounted) Navigator.pop(ctx);
        },
      ),
    );
  }
}

class _ProfileSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<String> items;
  final Color color;
  final String emptyHint;
  const _ProfileSection({required this.icon, required this.title, required this.items, required this.color, required this.emptyHint});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.divider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 8),
              Text(title, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
            ]),
            const SizedBox(height: 12),
            if (items.isEmpty)
              Text(emptyHint, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic))
            else
              Wrap(
                spacing: 6, runSpacing: 6,
                children: items.map((item) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: color.withValues(alpha: 0.2))),
                  child: Text(item, style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w500)),
                )).toList(),
              ),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label, value;
  final Color color;
  const _InfoTile({required this.icon, required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.divider)),
      child: Row(children: [
        Icon(icon, size: 24, color: color),
        const SizedBox(width: 14),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: 2),
          Text(value, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
        ]),
      ]),
    );
  }
}

// ── Contexts Tab ──────────────────────────────────────────────────────────────
class _ContextsTab extends ConsumerWidget {
  final int personId;
  const _ContextsTab({required this.personId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contextsAsync = ref.watch(personContextsProvider(personId));

    return contextsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
      error: (e, _) => Center(child: Text('$e')),
      data: (contexts) => ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(children: [
            Text('${contexts.length} contextes', style: Theme.of(context).textTheme.titleSmall),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () => _showAddContextSheet(context, ref, personId),
              icon: const Icon(Icons.add, size: 14),
              label: const Text('Ajouter'),
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
            ),
          ]),
          const SizedBox(height: 20),
          if (contexts.isEmpty)
            Center(child: Padding(padding: const EdgeInsets.all(40), child: Column(children: [
              const Icon(Icons.push_pin_outlined, size: 48, color: AppColors.textMuted),
              const SizedBox(height: 12),
              Text('Aucun contexte pour le moment', style: Theme.of(context).textTheme.bodyMedium),
            ])))
          else
            ...contexts.map((ctx) => Padding(
              padding: const EdgeInsets.only(bottom: 12), 
              child: Dismissible(
                key: Key('ctx_${ctx.id}'),
                direction: DismissDirection.endToStart,
                background: _buildDeleteBackground(),
                onDismissed: (_) => ref.read(personContextsProvider(personId).notifier).deleteContext(ctx.id),
                child: ContextCard(entry: ctx),
              ),
            )),
        ],
      ),
    );
  }

  void _showAddContextSheet(BuildContext context, WidgetRef ref, int personId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => _AddContextSheet(
        personId: personId,
        onSave: (entry) async {
          await ref.read(personContextsProvider(personId).notifier).addContext(entry);
          if (context.mounted) Navigator.pop(ctx);
        },
      ),
    );
  }
}

// ── Emotions Tab ──────────────────────────────────────────────────────────────
class _EmotionsTab extends ConsumerWidget {
  final int personId;
  const _EmotionsTab({required this.personId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emotionsAsync = ref.watch(personEmotionsProvider(personId));

    return emotionsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
      error: (e, _) => Center(child: Text('$e')),
      data: (logs) => ListView(
        padding: const EdgeInsets.all(20),
        children: [
          if (logs.isNotEmpty) ...[
            Text('Évolution de l\'intensité', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 16),
            Container(
              height: 160,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.divider)),
              child: _EmotionChart(logs: logs),
            ),
            const SizedBox(height: 24),
          ],
          Row(children: [
            Text('Historique (${logs.length})', style: Theme.of(context).textTheme.titleSmall),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () => _showAddEmotionSheet(context, ref, personId),
              icon: const Icon(Icons.add_chart_rounded, size: 14),
              label: const Text('Logger'),
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
            ),
          ]),
          const SizedBox(height: 16),
          if (logs.isEmpty)
            Center(child: Padding(padding: const EdgeInsets.all(40), child: Column(children: [
              const Icon(Icons.mood_rounded, size: 48, color: AppColors.textMuted),
              const SizedBox(height: 12),
              Text('Aucune émotion enregistrée', style: Theme.of(context).textTheme.bodyMedium),
            ])))
          else
            ...logs.map((log) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Dismissible(
                key: Key('emotion_${log.id}'),
                direction: DismissDirection.endToStart,
                background: _buildDeleteBackground(),
                onDismissed: (_) => ref.read(personEmotionsProvider(personId).notifier).deleteEmotion(log.id),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.divider)),
                  child: Row(children: [
                    EmotionChip(emotion: log.emotion, intensity: log.intensity),
                    const SizedBox(width: 12),
                    Expanded(child: Text(log.note ?? log.context ?? '', style: Theme.of(context).textTheme.bodySmall, maxLines: 2, overflow: TextOverflow.ellipsis)),
                    const SizedBox(width: 8),
                    Text(DateFormat('dd/MM', 'fr_FR').format(log.date), style: Theme.of(context).textTheme.labelSmall),
                  ]),
                ),
              ),
            )),
        ],
      ),
    );
  }

  void _showAddEmotionSheet(BuildContext context, WidgetRef ref, int personId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => _AddEmotionSheet(
        personId: personId,
        onSave: (log) async {
          await ref.read(personEmotionsProvider(personId).notifier).addEmotion(log);
          if (context.mounted) Navigator.pop(ctx);
        },
      ),
    );
  }
}

class _EmotionChart extends StatelessWidget {
  final List<EmotionLog> logs;
  const _EmotionChart({required this.logs});

  @override
  Widget build(BuildContext context) {
    final spots = logs.reversed.toList().asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value.intensity.toDouble())).toList();
    return LineChart(LineChartData(
      gridData: const FlGridData(show: false),
      titlesData: const FlTitlesData(show: false),
      borderData: FlBorderData(show: false),
      minY: 1, maxY: 10,
      lineBarsData: [LineChartBarData(
        spots: spots,
        isCurved: true,
        color: AppColors.secondary,
        barWidth: 3,
        dotData: const FlDotData(show: true),
        belowBarData: BarAreaData(show: true, color: AppColors.secondary.withValues(alpha: 0.1)),
      )],
    ));
  }
}

// ── Interactions Tab ──────────────────────────────────────────────────────────
class _InteractionsTab extends ConsumerWidget {
  final int personId;
  const _InteractionsTab({required this.personId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final interactionsAsync = ref.watch(personInteractionsProvider(personId));

    return interactionsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
      error: (e, _) => Center(child: Text('$e')),
      data: (interactions) => ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(children: [
            Text('${interactions.length} interactions', style: Theme.of(context).textTheme.titleSmall),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () => _showAddInteractionSheet(context, ref, personId),
              icon: const Icon(Icons.add_comment_rounded, size: 14),
              label: const Text('Ajouter'),
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
            ),
          ]),
          const SizedBox(height: 20),
          if (interactions.isEmpty)
             Center(child: Padding(padding: const EdgeInsets.all(40), child: Column(children: [
              const Icon(Icons.chat_bubble_outline_rounded, size: 48, color: AppColors.textMuted),
              const SizedBox(height: 12),
              Text('Aucune interaction récente', style: Theme.of(context).textTheme.bodyMedium),
            ])))
          else
            ...interactions.map((i) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Dismissible(
                key: Key('interaction_${i.id}'),
                direction: DismissDirection.endToStart,
                background: _buildDeleteBackground(),
                onDismissed: (_) => ref.read(personInteractionsProvider(personId).notifier).deleteInteraction(i.id),
                child: RelationTimeline(interactions: [i]), // Single item for the timeline row
              ),
            )),
        ],
      ),
    );
  }

  void _showAddInteractionSheet(BuildContext context, WidgetRef ref, int personId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => _AddInteractionSheet(
        personId: personId,
        onSave: (interaction) async {
          await ref.read(personInteractionsProvider(personId).notifier).addInteraction(interaction);
          if (context.mounted) Navigator.pop(ctx);
        },
      ),
    );
  }
}

// ── Relation Tab ──────────────────────────────────────────────────────────────
class _RelationTab extends StatelessWidget {
  final int personId;
  final AsyncValue<RelationshipScore> scoreAsync;
  const _RelationTab({required this.personId, required this.scoreAsync});

  @override
  Widget build(BuildContext context) {
    return scoreAsync.when(
      loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
      error: (e, _) => Center(child: Text('$e')),
      data: (score) => ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppColors.divider)),
            child: Column(
              children: [
                ScoreGauge(score: score.score, label: 'Santé de la relation', size: 160),
                const SizedBox(height: 24),
                Text('Score global de connexion', style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text('Détails par piliers', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 16),
          _ScoreBar(icon: Icons.lock_outline_rounded, label: 'Confiance', value: score.trustLevel, color: AppColors.primary),
          const SizedBox(height: 16),
          _ScoreBar(icon: Icons.chat_bubble_outline_rounded, label: 'Communication', value: score.communicationLevel, color: AppColors.accent),
          const SizedBox(height: 16),
          _ScoreBar(icon: Icons.favorite_border_rounded, label: 'Proximité émotionnelle', value: score.emotionalCloseness, color: AppColors.secondary),
          const SizedBox(height: 32),
          Text('Dernière évaluation : ${DateFormat('dd MMM yyyy', 'fr_FR').format(score.lastEvaluated)}',
            style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.center),
          const SizedBox(height: 20),
          ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.refresh_rounded, size: 16), label: const Text('Réévaluer maintenant')),
        ],
      ),
    );
  }
}

class _ScoreBar extends StatelessWidget {
  final IconData icon;
  final String label;
  final double value;
  final Color color;
  const _ScoreBar({required this.icon, required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.divider)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 8),
            Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
            const Spacer(),
            Text('${value.toInt()}%', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: color)),
          ]),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(value: value / 100, minHeight: 8, backgroundColor: color.withValues(alpha: 0.1), valueColor: AlwaysStoppedAnimation<Color>(color)),
          ),
        ],
      ),
    );
  }
}

// ── CRUD Sheets ────────────────────────────────────────────────────────────────

class _AddContextSheet extends StatefulWidget {
  final int personId;
  final Function(ContextEntry) onSave;
  const _AddContextSheet({required this.personId, required this.onSave});

  @override
  State<_AddContextSheet> createState() => _AddContextSheetState();
}

class _AddContextSheetState extends State<_AddContextSheet> {
  final _contentController = TextEditingController();
  String _selectedCategory = 'général';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Nouveau contexte', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          children: ['général', 'travail', 'famille', 'loisir', 'secret'].map((cat) => GestureDetector(
            onTap: () => setState(() => _selectedCategory = cat),
            child: Chip(
              label: Text(cat),
              backgroundColor: _selectedCategory == cat ? AppColors.primary.withValues(alpha: 0.2) : AppColors.surface2,
              side: BorderSide(color: _selectedCategory == cat ? AppColors.primary : AppColors.divider),
            ),
          )).toList(),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _contentController,
          maxLines: 3,
          decoration: const InputDecoration(hintText: 'Notes sur le contexte...', border: OutlineInputBorder()),
        ),
        const SizedBox(height: 20),
        SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {
          if (_contentController.text.isEmpty) return;
          final entry = ContextEntry()
            ..personId = widget.personId
            ..category = _selectedCategory
            ..title = _contentController.text.split('\n').first
            ..description = _contentController.text
            ..importance = 3
            ..date = DateTime.now()
            ..createdAt = DateTime.now();
          widget.onSave(entry);
        }, child: const Text('Sauvegarder'))),
      ]),
    );
  }
}

class _AddEmotionSheet extends StatefulWidget {
  final int personId;
  final Function(EmotionLog) onSave;
  const _AddEmotionSheet({required this.personId, required this.onSave});

  @override
  State<_AddEmotionSheet> createState() => _AddEmotionSheetState();
}

class _AddEmotionSheetState extends State<_AddEmotionSheet> {
  String _selectedEmotion = 'Joie';
  double _intensity = 5;
  final _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Log d\'émotion', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          children: ['Joie', 'Colère', 'Tristesse', 'Peur', 'Surprise', 'Dégoût', 'Amour'].map((e) => GestureDetector(
            onTap: () => setState(() => _selectedEmotion = e),
            child: Chip(
              label: Text(e),
              backgroundColor: _selectedEmotion == e ? AppColors.secondary.withValues(alpha: 0.2) : AppColors.surface2,
              side: BorderSide(color: _selectedEmotion == e ? AppColors.secondary : AppColors.divider),
            ),
          )).toList(),
        ),
        const SizedBox(height: 20),
        Text('Intensité : ${_intensity.toInt()}/10'),
        Slider(value: _intensity, min: 1, max: 10, divisions: 9, activeColor: AppColors.secondary, onChanged: (v) => setState(() => _intensity = v)),
        const SizedBox(height: 16),
        TextField(controller: _noteController, decoration: const InputDecoration(hintText: 'Une note ?', border: OutlineInputBorder())),
        const SizedBox(height: 20),
        SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {
          final log = EmotionLog()
            ..personId = widget.personId
            ..emotion = _selectedEmotion
            ..intensity = _intensity.toInt()
            ..note = _noteController.text
            ..date = DateTime.now();
          widget.onSave(log);
        }, child: const Text('Logger'))),
      ]),
    );
  }
}

class _AddInteractionSheet extends StatefulWidget {
  final int personId;
  final Function(Interaction) onSave;
  const _AddInteractionSheet({required this.personId, required this.onSave});

  @override
  State<_AddInteractionSheet> createState() => _AddInteractionSheetState();
}

class _AddInteractionSheetState extends State<_AddInteractionSheet> {
  String _type = 'Appel';
  final _summaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Nouvelle interaction', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          children: ['Appel', 'Message', 'Rencontre', 'Cadeau', 'Autre'].map((t) => GestureDetector(
            onTap: () => setState(() => _type = t),
            child: Chip(
              label: Text(t),
              backgroundColor: _type == t ? AppColors.primary.withValues(alpha: 0.2) : AppColors.surface2,
            ),
          )).toList(),
        ),
        const SizedBox(height: 16),
        TextField(controller: _summaryController, maxLines: 2, decoration: const InputDecoration(hintText: 'Résumé...', border: OutlineInputBorder())),
        const SizedBox(height: 20),
        SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {
          final interaction = Interaction()
            ..personId = widget.personId
            ..type = _type
            ..summary = _summaryController.text
            ..qualityScore = 5
            ..date = DateTime.now()
            ..createdAt = DateTime.now();
          widget.onSave(interaction);
        }, child: const Text('Ajouter'))),
      ]),
    );
  }
}

class _EditProfileSheet extends StatefulWidget {
  final int personId;
  final Profile? profile;
  final Function(Profile) onSave;
  const _EditProfileSheet({required this.personId, this.profile, required this.onSave});

  @override
  State<_EditProfileSheet> createState() => _EditProfileSheetState();
}

class _EditProfileSheetState extends State<_EditProfileSheet> {
  late Profile _current;

  @override
  void initState() {
    super.initState();
    _current = widget.profile ?? (Profile()..personId = widget.personId);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Modifier le profil (Âme)', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 20),
          _buildListEditor('Désirs', _current.desires, (val) => setState(() => _current.desires = val)),
          _buildListEditor('Rêves', _current.dreams, (val) => setState(() => _current.dreams = val)),
          _buildListEditor('Peurs', _current.fears, (val) => setState(() => _current.fears = val)),
          _buildListEditor('Loves', _current.loves, (val) => setState(() => _current.loves = val)),
          _buildListEditor('Values', _current.values, (val) => setState(() => _current.values = val)),
          const SizedBox(height: 24),
          SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => widget.onSave(_current), child: const Text('Tout sauvegarder'))),
        ]),
      ),
    );
  }

  Widget _buildListEditor(String title, List<String> items, Function(List<String>) onChanged) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      Wrap(spacing: 8, children: [
        ...items.map((item) => Chip(
          label: Text(item, style: const TextStyle(fontSize: 12)),
          onDeleted: () {
            final newList = List<String>.from(items)..remove(item);
            onChanged(newList);
          },
        )),
        ActionChip(label: const Icon(Icons.add, size: 14), onPressed: () => _showAddItemDialog(title, items, onChanged)),
      ]),
      const SizedBox(height: 16),
    ]);
  }

  void _showAddItemDialog(String title, List<String> items, Function(List<String>) onChanged) {
    final controller = TextEditingController();
    showDialog(context: context, builder: (ctx) => AlertDialog(
      title: Text('Ajouter : $title'),
      content: TextField(controller: controller, autofocus: true),
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

Widget _buildDeleteBackground() {
  return Container(
    alignment: Alignment.centerRight,
    padding: const EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(color: AppColors.error.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
    child: const Icon(Icons.delete_outline_rounded, color: AppColors.error),
  );
}
