import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../providers/persons_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/person.dart';

class AddPersonScreen extends ConsumerStatefulWidget {
  const AddPersonScreen({super.key});

  @override
  ConsumerState<AddPersonScreen> createState() => _AddPersonScreenState();
}

class _AddPersonScreenState extends ConsumerState<AddPersonScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _notesController = TextEditingController();

  RelationType _selectedType = RelationType.ami;
  String _selectedAvatar = '👤';
  DateTime? _metAt;
  DateTime? _birthday;
  bool _isLoading = false;

  final List<String> _avatarOptions = [
    '👤', '👨', '👩', '🧑', '👴', '👵', '👦', '👧',
    '🧔', '👩‍🦱', '👨‍🦱', '👩‍🦳', '🧕', '👲', '🎅', '🧙',
    '🦸', '🧑‍💼', '🧑‍🔬', '🧑‍🎨', '🧑‍🏫', '🧑‍⚕️', '🧑‍🍳', '🧑‍🚀',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    final person = Person()
      ..name = _nameController.text.trim()
      ..avatar = _selectedAvatar
      ..relationType = _selectedType
      ..metAt = _metAt
      ..birthday = _birthday
      ..notes = _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim()
      ..createdAt = DateTime.now();

    final id = await ref.read(personsProvider.notifier).addPerson(person);
    if (mounted) {
      context.pop();
      context.push('/persons/$id');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nouvelle Personne'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => context.pop(),
        ),
        actions: [
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(12),
              child: CircularProgressIndicator(
                  strokeWidth: 2, color: AppColors.primary),
            )
          else
            TextButton(
              onPressed: _submit,
              child: const Text('Ajouter',
                  style: TextStyle(fontWeight: FontWeight.w700)),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Avatar picker
            _buildAvatarPicker().animate().fadeIn(duration: 300.ms),
            const SizedBox(height: 24),
            // Name
            _buildSection(
              context,
              title: 'Nom',
              child: TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Prénom et/ou nom',
                  prefixIcon: Icon(Icons.person_outline_rounded),
                ),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Le nom est requis' : null,
                textCapitalization: TextCapitalization.words,
              ),
            ).animate().fadeIn(duration: 300.ms, delay: 50.ms),
            const SizedBox(height: 20),
            // Relation type
            _buildSection(
              context,
              title: 'Type de relation',
              child: _buildRelationTypeGrid(),
            ).animate().fadeIn(duration: 300.ms, delay: 100.ms),
            const SizedBox(height: 20),
            // Met at date
            _buildSection(
              context,
              title: 'Date de rencontre',
              child: _buildDatePicker(
                label: 'Quand vous êtes-vous rencontrés ?',
                value: _metAt,
                icon: Icons.handshake_outlined,
                onPicked: (d) => setState(() => _metAt = d),
              ),
            ).animate().fadeIn(duration: 300.ms, delay: 150.ms),
            const SizedBox(height: 20),
            // Birthday
            _buildSection(
              context,
              title: 'Anniversaire',
              child: _buildDatePicker(
                label: 'Date de naissance',
                value: _birthday,
                icon: Icons.cake_outlined,
                onPicked: (d) => setState(() => _birthday = d),
              ),
            ).animate().fadeIn(duration: 300.ms, delay: 200.ms),
            const SizedBox(height: 20),
            // Notes
            _buildSection(
              context,
              title: 'Notes',
              child: TextFormField(
                controller: _notesController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Quelque chose à retenir sur cette personne...',
                  alignLabelWithHint: true,
                ),
              ),
            ).animate().fadeIn(duration: 300.ms, delay: 250.ms),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _isLoading ? null : _submit,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Ajouter la personne',
                  style: TextStyle(fontSize: 16)),
            ).animate().fadeIn(duration: 300.ms, delay: 300.ms),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarPicker() {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: _showAvatarPicker,
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.15),
                shape: BoxShape.circle,
                border:
                    Border.all(color: AppColors.primary.withValues(alpha: 0.5), width: 2),
              ),
              child: Center(
                child: Text(_selectedAvatar,
                    style: const TextStyle(fontSize: 42)),
              ),
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: _showAvatarPicker,
            child: const Text('Changer l\'avatar'),
          ),
        ],
      ),
    );
  }

  void _showAvatarPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Choisir un avatar',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _avatarOptions.map((emoji) {
                final selected = emoji == _selectedAvatar;
                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedAvatar = emoji);
                    Navigator.pop(context);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.primary.withValues(alpha: 0.2)
                          : AppColors.surface2,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: selected ? AppColors.primary : AppColors.divider,
                        width: selected ? 2 : 1,
                      ),
                    ),
                    child: Center(
                        child: Text(emoji,
                            style: const TextStyle(fontSize: 26))),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRelationTypeGrid() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: RelationType.values.map((type) {
        final selected = _selectedType == type;
        final color = _typeColor(type);
        return GestureDetector(
          onTap: () => setState(() => _selectedType = type),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: selected ? color.withValues(alpha: 0.2) : AppColors.surface2,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: selected ? color : AppColors.divider,
                width: selected ? 1.5 : 1,
              ),
            ),
            child: Text(
              '${_typeIcon(type)} ${_typeLabel(type)}',
              style: TextStyle(
                fontSize: 13,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                color: selected ? color : AppColors.textSecondary,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDatePicker({
    required String label,
    required DateTime? value,
    required IconData icon,
    required ValueChanged<DateTime> onPicked,
  }) {
    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: value ?? DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
          builder: (context, child) => Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.dark(
                primary: AppColors.primary,
                surface: AppColors.surface,
              ),
            ),
            child: child!,
          ),
        );
        if (picked != null) onPicked(picked);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.surface2,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: AppColors.textSecondary),
            const SizedBox(width: 12),
            Text(
              value != null
                  ? DateFormat('dd MMMM yyyy', 'fr_FR').format(value)
                  : label,
              style: TextStyle(
                fontSize: 14,
                color: value != null
                    ? AppColors.textPrimary
                    : AppColors.textMuted,
              ),
            ),
            const Spacer(),
            if (value != null)
              const Icon(Icons.check_circle_rounded,
                  size: 16, color: AppColors.accent),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context,
      {required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 10),
        child,
      ],
    );
  }

  String _typeLabel(RelationType t) {
    switch (t) {
      case RelationType.ami:
        return 'Ami';
      case RelationType.famille:
        return 'Famille';
      case RelationType.partenaire:
        return 'Partenaire';
      case RelationType.collegue:
        return 'Collègue';
      case RelationType.mentor:
        return 'Mentor';
      case RelationType.connaissance:
        return 'Connaissance';
      case RelationType.autre:
        return 'Autre';
    }
  }

  String _typeIcon(RelationType t) {
    switch (t) {
      case RelationType.ami:
        return '👫';
      case RelationType.famille:
        return '👨‍👩‍👧';
      case RelationType.partenaire:
        return '❤️';
      case RelationType.collegue:
        return '💼';
      case RelationType.mentor:
        return '🧠';
      case RelationType.connaissance:
        return '🤝';
      case RelationType.autre:
        return '✨';
    }
  }

  Color _typeColor(RelationType t) {
    switch (t) {
      case RelationType.ami:
        return AppColors.relationFriend;
      case RelationType.famille:
        return AppColors.relationFamily;
      case RelationType.partenaire:
        return AppColors.relationPartner;
      case RelationType.collegue:
        return AppColors.relationColleague;
      case RelationType.mentor:
        return AppColors.relationMentor;
      default:
        return AppColors.relationOther;
    }
  }
}
