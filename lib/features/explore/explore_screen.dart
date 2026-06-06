import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/mock_data.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/event_category.dart';
import '../../l10n/app_localizations.dart';
import '../event_detail/event_detail_screen.dart';
import 'explore_provider.dart';
import 'widgets/event_card.dart';

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(exploreProvider);
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    final emptyMessage = state.searchQuery.isNotEmpty
        ? l10n.noSearchResults
        : l10n.noEventsInCategory;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.screenTitleExplore),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(52),
          child: _CategoryChips(selected: state.selectedCategory),
        ),
      ),
      body: Column(
        children: [
          _SearchBar(controller: _searchController),
          if (state.availableCities.length > 1)
            _CityFilter(
              availableCities: state.availableCities,
              selectedCity: state.selectedCity,
            ),
          Expanded(
            child: state.events.isEmpty
                ? _EmptyState(theme: theme, message: emptyMessage)
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
          ),
        ],
      ),
    );
  }
}

// ─── Barre de recherche ───────────────────────────────────────────────────────

class _SearchBar extends ConsumerWidget {
  const _SearchBar({required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: TextField(
        controller: controller,
        onChanged: (v) => ref.read(exploreProvider.notifier).setSearch(v),
        style: const TextStyle(color: AppColors.textPrimary, fontSize: 15),
        decoration: InputDecoration(
          hintText: l10n.hintSearch,
          hintStyle: const TextStyle(
            color: AppColors.textDisabled,
            fontSize: 15,
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: AppColors.textSecondary,
            size: 20,
          ),
          suffixIcon: ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (context, value, child) => value.text.isEmpty
                ? const SizedBox.shrink()
                : IconButton(
                    icon: const Icon(
                      Icons.close_rounded,
                      size: 18,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () {
                      controller.clear();
                      ref.read(exploreProvider.notifier).setSearch('');
                    },
                  ),
          ),
          filled: true,
          fillColor: AppColors.surfaceVariantDark,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.borderDark),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.borderDark),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.green, width: 1.5),
          ),
        ),
      ),
    );
  }
}

// ─── Filtre ville ─────────────────────────────────────────────────────────────

class _CityFilter extends ConsumerWidget {
  const _CityFilter({
    required this.availableCities,
    required this.selectedCity,
  });
  final List<String> availableCities;
  final String? selectedCity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final isActive = selectedCity != null;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Container(
        height: 42,
        padding: const EdgeInsetsDirectional.only(start: 12, end: 4),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariantDark,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isActive ? AppColors.green : AppColors.borderDark,
            width: isActive ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 16,
              color: isActive ? AppColors.green : AppColors.textSecondary,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: DropdownButton<String?>(
                value: selectedCity,
                isExpanded: true,
                underline: const SizedBox.shrink(),
                dropdownColor: AppColors.surfaceVariantDark,
                iconEnabledColor: AppColors.textSecondary,
                style: TextStyle(
                  color: isActive
                      ? AppColors.textPrimary
                      : AppColors.textDisabled,
                  fontSize: 14,
                ),
                hint: Text(
                  l10n.filterAllCities,
                  style: const TextStyle(
                    color: AppColors.textDisabled,
                    fontSize: 14,
                  ),
                ),
                items: [
                  DropdownMenuItem<String?>(
                    value: null,
                    child: Text(
                      l10n.filterAllCities,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  ...availableCities.map(
                    (city) => DropdownMenuItem<String?>(
                      value: city,
                      child: Text(city),
                    ),
                  ),
                ],
                onChanged: (city) =>
                    ref.read(exploreProvider.notifier).selectCity(city),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Chips de catégorie ───────────────────────────────────────────────────────

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
                padding: const EdgeInsetsDirectional.only(start: 8),
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

// ─── État vide ────────────────────────────────────────────────────────────────

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
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
