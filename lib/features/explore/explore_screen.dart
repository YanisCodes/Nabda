import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/mock_data.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/event_category.dart';
import '../../l10n/app_localizations.dart';
import '../event_detail/event_detail_screen.dart';
import 'explore_provider.dart';
import 'widgets/event_card.dart';

class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(exploreProvider);
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.screenTitleExplore),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(52),
          child: _CategoryChips(selected: state.selectedCategory),
        ),
      ),
      body: state.events.isEmpty
          ? _EmptyState(theme: theme, message: l10n.noEventsInCategory)
          : ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              itemCount: state.events.length,
              itemBuilder: (context, i) => EventCard(
                event: state.events[i],
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        EventDetailScreen(event: state.events[i]),
                  ),
                ),
              ),
            ),
    );
  }
}

class _CategoryChips extends ConsumerWidget {
  const _CategoryChips({required this.selected});
  final EventCategory? selected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return SizedBox(
      height: 52,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          _Chip(
            label: l10n.chipAll,
            isSelected: selected == null,
            onTap: () =>
                ref.read(exploreProvider.notifier).selectCategory(null),
          ),
          ...kCategories.map((cat) => Padding(
                padding: const EdgeInsets.only(left: 8),
                child: _Chip(
                  label: _categoryLabel(l10n, cat.id),
                  isSelected: selected == cat.id,
                  onTap: () => ref
                      .read(exploreProvider.notifier)
                      .selectCategory(cat.id),
                ),
              )),
        ],
      ),
    );
  }
}

String _categoryLabel(AppLocalizations l10n, EventCategory cat) =>
    switch (cat) {
      EventCategory.formation => l10n.categoryFormation,
      EventCategory.sport => l10n.categorySport,
      EventCategory.culture => l10n.categoryCulture,
      EventCategory.ecologie => l10n.categoryEcologie,
      EventCategory.volontariat => l10n.categoryVolontariat,
    };

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.greenDark
              : AppColors.surfaceVariantDark,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.green : AppColors.borderDark,
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.greenLight : AppColors.textSecondary,
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.theme, required this.message});
  final ThemeData theme;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.search_off_rounded,
            size: 48,
            color: AppColors.textDisabled,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
