import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/wilayas.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/app_language.dart';
import '../onboarding/onboarding_screen.dart';
import 'profile_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Mon profil')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            _SectionLabel(label: 'Votre ville', theme: theme),
            const SizedBox(height: 12),
            _CityDropdown(selectedCity: state.city),
            const SizedBox(height: 28),
            _SectionLabel(label: 'Votre langue', theme: theme),
            const SizedBox(height: 12),
            _LanguageSelector(selectedLanguage: state.language),
            const SizedBox(height: 36),
            _SaveButton(state: state),
            const SizedBox(height: 32),
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
  const _CityDropdown({required this.selectedCity});
  final String? selectedCity;

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
          const Icon(Icons.location_on_outlined,
              color: AppColors.green, size: 20),
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
              hint: const Text(
                'Sélectionnez une wilaya',
                style: TextStyle(color: AppColors.textDisabled, fontSize: 15),
              ),
              items: kWilayas.map((w) {
                return DropdownMenuItem<String>(
                  value: w.nameFr,
                  child: Text(
                      '${w.code.toString().padLeft(2, '0')} — ${w.nameFr}'),
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
            color: selected ? AppColors.greenDark : AppColors.surfaceVariantDark,
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

class _SaveButton extends ConsumerWidget {
  const _SaveButton({required this.state});
  final ProfileState state;

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
          : const Text('Enregistrer les modifications'),
    );
  }
}

class _DangerZone extends ConsumerWidget {
  const _DangerZone();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Zone de danger',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () => _confirmClear(context, ref),
          icon: const Icon(Icons.delete_outline_rounded,
              size: 18, color: AppColors.error),
          label: const Text(
            'Effacer les données locales',
            style: TextStyle(color: AppColors.error),
          ),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.error, width: 1),
          ),
        ),
      ],
    );
  }

  void _confirmClear(BuildContext context, WidgetRef ref) {
    showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Effacer les données ?'),
        content: const Text(
          'Votre ville et vos préférences seront supprimées. '
          'Vous serez redirigé vers l\'accueil de configuration.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'Effacer',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    ).then((confirmed) async {
      if (confirmed != true) return;
      await ref.read(profileProvider.notifier).clearAll();
      if (!context.mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
        (_) => false,
      );
    });
  }
}
