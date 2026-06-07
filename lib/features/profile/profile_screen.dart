import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/mock_data.dart';
import '../../core/constants/wilayas.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/app_language.dart';
import '../../data/models/event_category.dart';
import '../../l10n/app_localizations.dart';
import '../favorites/favorites_provider.dart';
import '../feedback/feedback_helper.dart';
import '../onboarding/onboarding_screen.dart';
import 'profile_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileProvider);
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.screenTitleProfile)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            _SectionLabel(label: l10n.labelYourCity, theme: theme),
            const SizedBox(height: 12),
            _CityDropdown(
              selectedCity: state.city,
              hint: l10n.hintSelectWilaya,
            ),
            const SizedBox(height: 28),
            _SectionLabel(label: l10n.labelYourLanguage, theme: theme),
            const SizedBox(height: 12),
            _LanguageSelector(selectedLanguage: state.language),
            const SizedBox(height: 28),
            _SectionLabel(label: l10n.sectionInterests, theme: theme),
            const SizedBox(height: 12),
            _InterestsSelector(selected: state.interests),
            const SizedBox(height: 36),
            _SaveButton(state: state, label: l10n.btnSave),
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 24),
            const _FeedbackButton(),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 24),
            _DangerZone(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label, required this.theme});
  final String label;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: theme.textTheme.titleMedium?.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _CityDropdown extends ConsumerWidget {
  const _CityDropdown({required this.selectedCity, required this.hint});
  final String? selectedCity;
  final String hint;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderDark),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          const Icon(
            Icons.location_on_outlined,
            color: AppColors.green,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: DropdownButton<String>(
              value: selectedCity,
              isExpanded: true,
              underline: const SizedBox.shrink(),
              dropdownColor: AppColors.surfaceVariantDark,
              iconEnabledColor: AppColors.textSecondary,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 15,
              ),
              hint: Text(
                hint,
                style: const TextStyle(
                  color: AppColors.textDisabled,
                  fontSize: 15,
                ),
              ),
              items: kWilayas.map((w) {
                return DropdownMenuItem<String>(
                  value: w.nameFr,
                  child: Text(
                    '${w.code.toString().padLeft(2, '0')} — ${w.nameFr}',
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  ref.read(profileProvider.notifier).setCity(value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguageSelector extends ConsumerWidget {
  const _LanguageSelector({required this.selectedLanguage});
  final AppLanguage selectedLanguage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        _LangChip(
          label: 'Français',
          lang: AppLanguage.fr,
          selected: selectedLanguage == AppLanguage.fr,
        ),
        const SizedBox(width: 10),
        _LangChip(
          label: 'العربية',
          lang: AppLanguage.ar,
          selected: selectedLanguage == AppLanguage.ar,
        ),
        const SizedBox(width: 10),
        _LangChip(
          label: 'Tamazight',
          lang: AppLanguage.tz,
          selected: selectedLanguage == AppLanguage.tz,
        ),
      ],
    );
  }
}

class _LangChip extends ConsumerWidget {
  const _LangChip({
    required this.label,
    required this.lang,
    required this.selected,
  });
  final String label;
  final AppLanguage lang;
  final bool selected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: GestureDetector(
        onTap: () => ref.read(profileProvider.notifier).setLanguage(lang),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected
                ? AppColors.greenDark
                : AppColors.surfaceVariantDark,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: selected ? AppColors.green : AppColors.borderDark,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selected ? AppColors.greenLight : AppColors.textSecondary,
              fontSize: 13,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

class _InterestsSelector extends ConsumerWidget {
  const _InterestsSelector({required this.selected});
  final Set<EventCategory> selected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: kCategories.map((cat) {
        final isSelected = selected.contains(cat.id);
        return GestureDetector(
          onTap: () =>
              ref.read(profileProvider.notifier).toggleInterest(cat.id),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.amberDark.withValues(alpha: 0.25)
                  : AppColors.surfaceVariantDark,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isSelected ? AppColors.amber : AppColors.borderDark,
                width: isSelected ? 1.5 : 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _categoryIcon(cat.id),
                  size: 15,
                  color: isSelected ? AppColors.amber : AppColors.textSecondary,
                ),
                const SizedBox(width: 6),
                Text(
                  _categoryLabel(l10n, cat.id),
                  style: TextStyle(
                    color: isSelected
                        ? AppColors.amber
                        : AppColors.textSecondary,
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  IconData _categoryIcon(EventCategory cat) => switch (cat) {
    EventCategory.formation => Icons.school_rounded,
    EventCategory.sport => Icons.sports_soccer_rounded,
    EventCategory.culture => Icons.theater_comedy_rounded,
    EventCategory.ecologie => Icons.eco_rounded,
    EventCategory.volontariat => Icons.volunteer_activism_rounded,
  };

  String _categoryLabel(AppLocalizations l10n, EventCategory cat) =>
      switch (cat) {
        EventCategory.formation => l10n.categoryFormation,
        EventCategory.sport => l10n.categorySport,
        EventCategory.culture => l10n.categoryCulture,
        EventCategory.ecologie => l10n.categoryEcologie,
        EventCategory.volontariat => l10n.categoryVolontariat,
      };
}

class _SaveButton extends ConsumerWidget {
  const _SaveButton({required this.state, required this.label});
  final ProfileState state;
  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: state.city != null && !state.isSaving
          ? () async {
              await ref.read(profileProvider.notifier).save();
              if (!context.mounted) return;
              Navigator.pop(context);
            }
          : null,
      child: state.isSaving
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : Text(label),
    );
  }
}

class _FeedbackButton extends StatelessWidget {
  const _FeedbackButton();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return OutlinedButton.icon(
      onPressed: () => _sendFeedback(context),
      icon: const Icon(Icons.feedback_outlined, size: 18),
      label: Text(l10n.btnReportProblem),
    );
  }

  Future<void> _sendFeedback(BuildContext context) async {
    if (!await launchFeedbackEmail()) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context).errorCantOpenEmail),
          ),
        );
      }
    }
  }
}

class _DangerZone extends ConsumerWidget {
  const _DangerZone();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.sectionDangerZone,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () => _confirmClear(context, ref),
          icon: const Icon(
            Icons.delete_outline_rounded,
            size: 18,
            color: AppColors.error,
          ),
          label: Text(
            l10n.btnClearData,
            style: const TextStyle(color: AppColors.error),
          ),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.error, width: 1),
          ),
        ),
      ],
    );
  }

  void _confirmClear(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.dialogClearTitle),
        content: Text(l10n.dialogClearContent),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.actionCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              l10n.actionDelete,
              style: const TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    ).then((confirmed) async {
      if (confirmed != true) return;
      await ref.read(profileProvider.notifier).clearAll();
      ref.read(favoritesProvider.notifier).clear();
      if (!context.mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
        (_) => false,
      );
    });
  }
}
