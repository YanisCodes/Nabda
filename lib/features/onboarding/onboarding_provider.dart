import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/local/data_providers.dart';
import '../../data/local/preferences.dart';
import '../../data/models/app_language.dart';

class OnboardingState {
  const OnboardingState({
    this.city,
    this.language = AppLanguage.fr,
    this.isSaving = false,
  });

  final String? city;
  final AppLanguage language;
  final bool isSaving;

  bool get isValid => city != null && city!.isNotEmpty;

  OnboardingState copyWith({
    String? city,
    AppLanguage? language,
    bool? isSaving,
  }) {
    return OnboardingState(
      city: city ?? this.city,
      language: language ?? this.language,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}

class OnboardingNotifier extends Notifier<OnboardingState> {
  @override
  OnboardingState build() => const OnboardingState();

  void setCity(String city) {
    state = state.copyWith(city: city);
  }

  void setLanguage(AppLanguage language) {
    state = state.copyWith(language: language);
  }

  Future<void> complete() async {
    if (!state.isValid) return;
    state = state.copyWith(isSaving: true);
    final prefs = ref.read(preferencesProvider);
    await prefs.setCity(state.city!);
    await prefs.setLanguage(state.language);
    ref.read(localeProvider.notifier).state = languageToLocale(state.language);
    state = state.copyWith(isSaving: false);
  }
}

final onboardingProvider =
    NotifierProvider<OnboardingNotifier, OnboardingState>(
  OnboardingNotifier.new,
);
