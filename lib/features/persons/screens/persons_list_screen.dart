import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../providers/persons_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/person.dart';
import '../../../shared/widgets/person_card.dart';
import '../../../core/utils/icon_utils.dart';

class PersonsListScreen extends ConsumerStatefulWidget {
  const PersonsListScreen({super.key});

  @override
  ConsumerState<PersonsListScreen> createState() => _PersonsListScreenState();
}

class _PersonsListScreenState extends ConsumerState<PersonsListScreen> {
  RelationType? _selectedFilter;
  String _searchQuery = '';
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final personsAsync = ref.watch(personsProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mes Personnes',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        personsAsync.when(
                          data: (list) => Text(
                            '${list.length} personne${list.length > 1 ? 's' : ''}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          loading: () => const SizedBox.shrink(),
                          error: (_, _) => const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                ],
              ).animate().fadeIn(duration: 300.ms),
            ),
            const SizedBox(height: 16),
            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _searchController,
                onChanged: (v) => setState(() => _searchQuery = v.toLowerCase()),
                decoration: InputDecoration(
                  hintText: 'Rechercher...',
                  prefixIcon: const Icon(Icons.search_rounded,
                      color: AppColors.textSecondary),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close_rounded,
                              color: AppColors.textSecondary),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _searchQuery = '');
                          },
                        )
                      : null,
                ),
              ),
            ).animate().fadeIn(duration: 300.ms, delay: 50.ms),
            const SizedBox(height: 12),
            // Filter chips
            SizedBox(
              height: 38,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _FilterChip(
                    label: 'Tous',
                    selected: _selectedFilter == null,
                    onTap: () => setState(() => _selectedFilter = null),
                  ),
                  ...RelationType.values.map(
                    (t) => _FilterChip(
                      label: _typeLabel(t),
                      icon: IconUtils.getIconForRelation(t.name),
                      selected: _selectedFilter == t,
                      color: _typeColor(t),
                      onTap: () => setState(() => _selectedFilter = t),
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 300.ms, delay: 100.ms),
            const SizedBox(height: 16),
            // List
            Expanded(
              child: personsAsync.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
                error: (e, _) => Center(child: Text('Erreur: $e')),
                data: (persons) {
                  final filtered = persons.where((p) {
                    final matchFilter =
                        _selectedFilter == null || p.relationType == _selectedFilter;
                    final matchSearch =
                        _searchQuery.isEmpty || p.name.toLowerCase().contains(_searchQuery);
                    return matchFilter && matchSearch;
                  }).toList();

                  if (filtered.isEmpty) {
                    return _EmptyState(
                      hasFilter: _selectedFilter != null || _searchQuery.isNotEmpty,
                      onAddTap: () => context.push('/persons/add'),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: filtered.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final person = filtered[index];
                      return Dismissible(
                        key: Key('person_${person.id}'),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(color: AppColors.error, borderRadius: BorderRadius.circular(16)),
                          child: const Icon(Icons.person_remove_rounded, color: Colors.white),
                        ),
                        confirmDismiss: (direction) async {
                          return await showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text('Supprimer ?'),
                              content: Text('Veux-tu vraiment supprimer ${person.name} et toutes ses données ?'),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Annuler')),
                                TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Supprimer', style: TextStyle(color: AppColors.error))),
                              ],
                            ),
                          );
                        },
                        onDismissed: (_) => ref.read(personsProvider.notifier).deletePerson(person.id),
                        child: PersonCard(
                          person: person,
                          animationIndex: index,
                          onTap: () => context.push('/persons/${person.id}'),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/persons/add'),
        child: const Icon(Icons.person_add_rounded),
      ).animate().scale(delay: 300.ms, duration: 400.ms, curve: Curves.elasticOut),
    );
  }

  String _typeLabel(RelationType t) {
    switch (t) {
      case RelationType.ami: return 'Ami';
      case RelationType.famille: return 'Famille';
      case RelationType.partenaire: return 'Partenaire';
      case RelationType.collegue: return 'Collègue';
      case RelationType.mentor: return 'Mentor';
      case RelationType.connaissance: return 'Connaissance';
      case RelationType.autre: return 'Autre';
    }
  }

  Color _typeColor(RelationType t) {
    switch (t) {
      case RelationType.ami: return AppColors.relationFriend;
      case RelationType.famille: return AppColors.relationFamily;
      case RelationType.partenaire: return AppColors.relationPartner;
      case RelationType.collegue: return AppColors.relationColleague;
      case RelationType.mentor: return AppColors.relationMentor;
      default: return AppColors.relationOther;
    }
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool selected;
  final Color? color;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    this.icon,
    required this.selected,
    this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.primary;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? c.withValues(alpha: 0.15) : AppColors.surface2,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? c : AppColors.divider,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 14, color: selected ? c : AppColors.textSecondary),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                color: selected ? c : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final bool hasFilter;
  final VoidCallback onAddTap;

  const _EmptyState({required this.hasFilter, required this.onAddTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            hasFilter ? Icons.search_off_rounded : Icons.people_outline_rounded,
            size: 64, color: AppColors.textMuted,
          ),
          const SizedBox(height: 16),
          Text(
            hasFilter ? 'Aucune personne trouvée' : 'Ta liste est vide',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            hasFilter
                ? 'Essaie un autre filtre ou une autre recherche'
                : 'Commence à ajouter des personnes importantes dans ta vie',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          if (!hasFilter) ...[
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onAddTap,
              icon: const Icon(Icons.person_add_rounded),
              label: const Text('Ajouter quelqu\'un'),
            ),
          ],
        ],
      ),
    );
  }
}
