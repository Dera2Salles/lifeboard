import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../providers/habits_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/models/habit.dart';
import '../../../shared/widgets/habit_ring.dart';
import '../../../core/utils/icon_utils.dart';

class HabitsScreen extends ConsumerWidget {
  const HabitsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitsAsync = ref.watch(habitsProvider);
    final todayLogsAsync = ref.watch(todayHabitLogsProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Habitudes', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800)).animate().fadeIn(duration: 300.ms),
                Text(DateFormat('EEEE d MMMM', 'fr_FR').format(DateTime.now()), style: Theme.of(context).textTheme.bodyMedium).animate().fadeIn(delay: 100.ms),
              ]),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: habitsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
                error: (e, _) => Center(child: Text('Erreur: $e')),
                data: (habits) {
                  if (habits.isEmpty) return _EmptyHabits(onAdd: () => _showAddHabitSheet(context, ref));
                  final logs = todayLogsAsync.value ?? {};
                  final completedCount = habits.where((h) => logs[h.id]?.completed == true).length;

                  return CustomScrollView(
                    slivers: [
                      // Progress header
                      SliverToBoxAdapter(child: _buildProgressHeader(context, completedCount, habits.length).animate().fadeIn(delay: 100.ms)),
                      // Today's rings
                      SliverToBoxAdapter(child: _buildTodayRings(context, habits, logs, ref).animate().fadeIn(delay: 150.ms)),
                      // All habits list
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
                          child: Text('Toutes les habitudes', style: Theme.of(context).textTheme.titleMedium),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => _HabitListTile(
                            habit: habits[index],
                            completed: logs[habits[index].id]?.completed == true,
                            onToggle: () => ref.read(habitsProvider.notifier).toggleToday(habits[index].id),
                            index: index,
                          ),
                          childCount: habits.length,
                        ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 80)),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddHabitSheet(context, ref),
        child: const Icon(Icons.add_rounded),
      ).animate().scale(delay: 300.ms, duration: 400.ms, curve: Curves.elasticOut),
    );
  }

  Widget _buildProgressHeader(BuildContext context, int done, int total) {
    final ratio = total == 0 ? 0.0 : done / total;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
          boxShadow: [
            BoxShadow(color: AppColors.accent.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))
          ],
        ),
        child: Column(children: [
          Row(children: [
            Text('$done/$total complétées', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
            const Spacer(),
            Text('${(ratio * 100).toInt()}%', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.accent)),
          ]),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: ratio, minHeight: 10,
              backgroundColor: AppColors.accent.withValues(alpha: 0.1),
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accent),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildTodayRings(BuildContext context, List<Habit> habits, Map<int, dynamic> logs, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("Aujourd'hui", style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 14),
        SizedBox(
          height: 115,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: habits.length,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, i) {
              final habit = habits[i];
              final done = logs[habit.id]?.completed == true;
              return HabitRing(
                icon: IconUtils.getIconForCategory(habit.category),
                title: habit.title,
                progress: done ? 1.0 : 0.0,
                color: Color(habit.color),
                completed: done,
                streak: habit.streak,
                size: 76,
                onTap: () => ref.read(habitsProvider.notifier).toggleToday(habit.id),
              );
            },
          ),
        ),
      ]),
    );
  }

  void _showAddHabitSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => _AddHabitSheet(onSave: (habit) async {
        await ref.read(habitsProvider.notifier).addHabit(habit);
        if (context.mounted) Navigator.pop(ctx);
      }),
    );
  }
}

class _HabitListTile extends StatelessWidget {
  final Habit habit;
  final bool completed;
  final VoidCallback onToggle;
  final int index;

  const _HabitListTile({required this.habit, required this.completed, required this.onToggle, required this.index});

  @override
  Widget build(BuildContext context) {
    final color = Color(habit.color);
    return Animate(
      effects: [FadeEffect(duration: 250.ms, delay: (index * 50).ms), SlideEffect(begin: const Offset(0.05, 0), end: Offset.zero, duration: 250.ms, delay: (index * 50).ms)],
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
        child: GestureDetector(
          onTap: onToggle,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: completed ? color.withValues(alpha: 0.1) : AppColors.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: completed ? color.withValues(alpha: 0.4) : AppColors.divider, width: completed ? 1.5 : 1),
            ),
            child: Row(children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
                child: Center(child: Icon(IconUtils.getIconForCategory(habit.category), color: color, size: 24)),
              ),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(habit.title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, decoration: completed ? TextDecoration.lineThrough : null)),
                Text(habit.frequencyLabel, style: Theme.of(context).textTheme.bodySmall),
              ])),
              if (habit.streak > 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: AppColors.warning.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      const Icon(Icons.local_fire_department_rounded, size: 12, color: AppColors.warning),
                      const SizedBox(width: 2),
                      Text('${habit.streak}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.warning)),
                    ],
                  ),
                ),
              const SizedBox(width: 10),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 28, height: 28,
                decoration: BoxDecoration(
                  color: completed ? color : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: completed ? color : AppColors.divider, width: 2),
                ),
                child: completed ? const Icon(Icons.check_rounded, size: 16, color: Colors.white) : null,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class _AddHabitSheet extends StatefulWidget {
  final Future<void> Function(Habit) onSave;
  const _AddHabitSheet({required this.onSave});

  @override
  State<_AddHabitSheet> createState() => _AddHabitSheetState();
}

class _AddHabitSheetState extends State<_AddHabitSheet> {
  final _titleController = TextEditingController();
  String _selectedCategory = 'santé';
  int _selectedColor = AppConstants.habitColors[0];
  String _selectedFrequency = 'daily';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Nouvelle habitude', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 20),
        // Category icon & color row
        Row(children: [
          Container(
            width: 56, height: 56,
            decoration: BoxDecoration(color: Color(_selectedColor).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(14), border: Border.all(color: Color(_selectedColor).withValues(alpha: 0.3))),
            child: Center(child: Icon(IconUtils.getIconForCategory(_selectedCategory), color: Color(_selectedColor), size: 28)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: AppConstants.habitColors.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (_, i) {
                  final c = AppConstants.habitColors[i];
                  return GestureDetector(
                    onTap: () => setState(() => _selectedColor = c),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 32, height: 32,
                      decoration: BoxDecoration(
                        color: Color(c),
                        shape: BoxShape.circle,
                        border: Border.all(color: _selectedColor == c ? Colors.white : Colors.transparent, width: 2.5),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ]),
        const SizedBox(height: 20),
        TextField(controller: _titleController, decoration: const InputDecoration(hintText: 'Nom de l\'habitude', prefixIcon: Icon(Icons.edit_rounded))),
        const SizedBox(height: 20),
        Text('Catégorie', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8, runSpacing: 8,
          children: ['santé', 'travail', 'sport', 'lecture', 'méditation', 'social'].map((cat) => GestureDetector(
            onTap: () => setState(() => _selectedCategory = cat),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: _selectedCategory == cat ? AppColors.primary.withValues(alpha: 0.15) : AppColors.surface2,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _selectedCategory == cat ? AppColors.primary : AppColors.divider),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(IconUtils.getIconForCategory(cat), size: 16, color: _selectedCategory == cat ? AppColors.primary : AppColors.textSecondary),
                  const SizedBox(width: 6),
                  Text(cat[0].toUpperCase() + cat.substring(1), style: TextStyle(fontSize: 12, color: _selectedCategory == cat ? AppColors.primary : AppColors.textSecondary)),
                ],
              ),
            ),
          )).toList(),
        ),
        const SizedBox(height: 20),
        Text('Fréquence', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: AppConstants.habitFrequencies.map((f) => GestureDetector(
            onTap: () => setState(() => _selectedFrequency = f),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: _selectedFrequency == f ? AppColors.primary.withValues(alpha: 0.15) : AppColors.surface2,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: _selectedFrequency == f ? AppColors.primary : AppColors.divider),
              ),
              child: Text(AppConstants.habitFrequencyLabels[f] ?? f, style: TextStyle(fontSize: 13, color: _selectedFrequency == f ? AppColors.primary : AppColors.textSecondary, fontWeight: _selectedFrequency == f ? FontWeight.w700 : FontWeight.w400)),
            ),
          )).toList(),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              if (_titleController.text.trim().isEmpty) return;
              final habit = Habit()
                ..title = _titleController.text.trim()
                ..icon = '⭐' // Still stored but UI uses category icon
                ..color = _selectedColor
                ..frequency = _selectedFrequency
                ..category = _selectedCategory
                ..streak = 0
                ..bestStreak = 0
                ..targetDays = 1
                ..isActive = true
                ..createdAt = DateTime.now();
              await widget.onSave(habit);
            },
            child: const Text('Créer l\'habitude'),
          ),
        ),
      ]),
    );
  }
}

class _EmptyHabits extends StatelessWidget {
  final VoidCallback onAdd;
  const _EmptyHabits({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      const Icon(Icons.sync_rounded, size: 56, color: AppColors.textMuted),
      const SizedBox(height: 16),
      Text('Aucune habitude', style: Theme.of(context).textTheme.headlineSmall),
      const SizedBox(height: 8),
      Text('Crée ta première habitude\npour commencer à progresser', style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
      const SizedBox(height: 24),
      ElevatedButton.icon(onPressed: onAdd, icon: const Icon(Icons.add_rounded), label: const Text('Créer une habitude')),
    ]));
  }
}
