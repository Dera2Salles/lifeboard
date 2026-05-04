import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/radar_chart_widget.dart';
import '../../../shared/widgets/insight_card.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final Map<String, double> _radarData = {
    'Curiosité': 0.8,
    'Empathie': 0.7,
    'Discipline': 0.6,
    'Créativité': 0.9,
    'Résilience': 0.5,
    'Communication': 0.75,
  };

  String? _selectedPersonality;
  String? _selectedLoveLanguage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader(context)),
            SliverToBoxAdapter(child: _buildRadar(context)),
            SliverToBoxAdapter(child: _buildPersonalitySection(context)),
            SliverToBoxAdapter(child: _buildGoalsSection(context)),
            SliverToBoxAdapter(child: _buildInsightsSection(context)),
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Mon Profil', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
            Text('Ta boussole intérieure 🧭', style: Theme.of(context).textTheme.bodyMedium),
          ])),
          Container(
            width: 64, height: 64,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 16, offset: const Offset(0, 4))],
            ),
            child: const Center(child: Text('🧬', style: TextStyle(fontSize: 30))),
          ),
        ]),
      ]).animate().fadeIn(duration: 300.ms),
    );
  }

  Widget _buildRadar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.divider),
        ),
        child: RadarChartWidget(data: _radarData, title: 'Mes Forces', color: AppColors.primary),
      ).animate().fadeIn(duration: 400.ms, delay: 100.ms),
    );
  }

  Widget _buildPersonalitySection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Personnalité & Amour', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 16),
        // Personality type
        _SectionCard(
          icon: '🧠',
          label: 'Type de personnalité',
          child: Wrap(
            spacing: 8, runSpacing: 8,
            children: ['INFP', 'ENFJ', 'INTJ', 'Ambivert', 'Introverti', 'Extraverti'].map((t) => GestureDetector(
              onTap: () => setState(() => _selectedPersonality = t),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _selectedPersonality == t ? AppColors.primary.withValues(alpha: 0.2) : AppColors.surface2,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _selectedPersonality == t ? AppColors.primary : AppColors.divider),
                ),
                child: Text(t, style: TextStyle(fontSize: 12, color: _selectedPersonality == t ? AppColors.primary : AppColors.textSecondary, fontWeight: _selectedPersonality == t ? FontWeight.w700 : FontWeight.w400)),
              ),
            )).toList(),
          ),
        ),
        const SizedBox(height: 14),
        // Love language
        _SectionCard(
          icon: '💝',
          label: 'Mon langage d\'amour',
          child: Column(
            children: AppConstants.loveLanguages.map((l) => GestureDetector(
              onTap: () => setState(() => _selectedLoveLanguage = l),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: _selectedLoveLanguage == l ? AppColors.secondary.withValues(alpha: 0.15) : AppColors.surface2,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _selectedLoveLanguage == l ? AppColors.secondary : AppColors.divider),
                ),
                child: Row(children: [
                  Text(l, style: TextStyle(fontSize: 13, color: _selectedLoveLanguage == l ? AppColors.secondary : AppColors.textSecondary, fontWeight: _selectedLoveLanguage == l ? FontWeight.w600 : FontWeight.w400)),
                  const Spacer(),
                  if (_selectedLoveLanguage == l) const Icon(Icons.check_circle_rounded, size: 16, color: AppColors.secondary),
                ]),
              ),
            )).toList(),
          ),
        ),
      ]).animate().fadeIn(duration: 400.ms, delay: 150.ms),
    );
  }

  Widget _buildGoalsSection(BuildContext context) {
    final goals = [
      _GoalData(title: 'Être plus présent pour mes proches', progress: 0.4, color: AppColors.primary),
      _GoalData(title: 'Développer ma discipline quotidienne', progress: 0.65, color: AppColors.accent),
      _GoalData(title: 'Améliorer ma communication', progress: 0.3, color: AppColors.secondary),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text('Mes Objectifs', style: Theme.of(context).textTheme.titleMedium),
          const Spacer(),
          TextButton.icon(onPressed: () {}, icon: const Icon(Icons.add, size: 14), label: const Text('Ajouter')),
        ]),
        const SizedBox(height: 12),
        ...goals.map((g) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.divider),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(child: Text(g.title, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600))),
                Text('${(g.progress * 100).toInt()}%', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: g.color)),
              ]),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(value: g.progress, minHeight: 7, backgroundColor: g.color.withValues(alpha: 0.15), valueColor: AlwaysStoppedAnimation<Color>(g.color)),
              ),
            ]),
          ),
        )),
      ]).animate().fadeIn(duration: 400.ms, delay: 200.ms),
    );
  }

  Widget _buildInsightsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('À retenir sur moi', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        InsightCard(emoji: '🌱', title: 'Croissance', body: 'Tu progresses chaque jour. Continue à nourrir tes relations et habitudes.', color: AppColors.accent),
        const SizedBox(height: 10),
        InsightCard(emoji: '🎯', title: 'Focus', body: 'Concentre-toi sur l\'essentiel : les personnes qui comptent vraiment.', color: AppColors.primary),
      ]).animate().fadeIn(duration: 400.ms, delay: 250.ms),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String icon, label;
  final Widget child;
  const _SectionCard({required this.icon, required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(icon, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
        ]),
        const SizedBox(height: 12),
        child,
      ]),
    );
  }
}

class _GoalData {
  final String title;
  final double progress;
  final Color color;
  const _GoalData({required this.title, required this.progress, required this.color});
}
