import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/wilayas.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/app_language.dart';
import '../home/home_screen.dart';
import 'onboarding_provider.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 48),
              _Header(theme: theme),
              const SizedBox(height: 48),
              _SectionLabel(label: 'Votre ville', theme: theme),
              const SizedBox(height: 12),
              _CityDropdown(selectedCity: state.city),
              const SizedBox(height: 32),
              _SectionLabel(label: 'Votre langue', theme: theme),
              const SizedBox(height: 12),
              _LanguageSelector(selectedLanguage: state.language),
              const SizedBox(height: 48),
              _StartButton(state: state),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: AppColors.greenDark,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.green, width: 1.5),
          ),
          child: const Icon(
            Icons.explore_rounded,
            color: AppColors.greenLight,
            size: 36,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'OTEJ Link',
          style: theme.textTheme.headlineLarge?.copyWith(
            color: AppColors.green,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Personnalisez votre expérience\npour découvrir les opportunités près de chez vous.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
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
              items: kWilayas.map((wilaya) {
                return DropdownMenuItem<String>(
                  value: wilaya.nameFr,
                  child: Text(
                    '${wilaya.code.toString().padLeft(2, '0')} — ${wilaya.nameFr}',
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  ref.read(onboardingProvider.notifier).setCity(value);
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
        onTap: () => ref.read(onboardingProvider.notifier).setLanguage(lang),
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

class _StartButton extends ConsumerWidget {
  const _StartButton({required this.state});
  final OnboardingState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: state.isValid && !state.isSaving
          ? () async {
              await ref.read(onboardingProvider.notifier).complete();
              if (!context.mounted) return;
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const HomeScreen()),
                (_) => false,
              );
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
          : const Text('Commencer'),
    );
  }
}
