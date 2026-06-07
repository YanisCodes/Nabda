import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/local/data_providers.dart';
import '../../data/local/preferences.dart';
import '../../data/models/app_language.dart';
import '../../data/models/event_category.dart';
import '../home/home_provider.dart';

class ProfileState {
  const ProfileState({
    this.city,
    required this.language,
    required this.interests,
    required this.isSaving,
  });

  final String? city;
  final AppLanguage language;
  final Set<EventCategory> interests;
  final bool isSaving;

  bool get hasChanges => true;

  ProfileState copyWith({
    String? city,
    AppLanguage? language,
    Set<EventCategory>? interests,
    bool? isSaving,
  }) => ProfileState(
    city: city ?? this.city,
    language: language ?? this.language,
    interests: interests ?? this.interests,
    isSaving: isSaving ?? this.isSaving,
  );
}

class ProfileNotifier extends Notifier<ProfileState> {
  @override
  ProfileState build() {
    final prefs = ref.read(preferencesProvider);
    return ProfileState(
      city: prefs.city,
      language: prefs.language,
      interests: prefs.interests,
      isSaving: false,
    );
  }

  void setCity(String city) => state = state.copyWith(city: city);

  void setLanguage(AppLanguage language) =>
      state = state.copyWith(language: language);

  void toggleInterest(EventCategory category) {
    final updated = Set<EventCategory>.from(state.interests);
    if (updated.contains(category)) {
      updated.remove(category);
    } else {
      updated.add(category);
    }
    state = state.copyWith(interests: updated);
  }

  Future<void> save() async {
    if (state.city == null) return;
    state = state.copyWith(isSaving: true);
    final prefs = ref.read(preferencesProvider);
    await prefs.setCity(state.city!);
    await prefs.setLanguage(state.language);
    await prefs.setInterests(state.interests);
    ref.read(localeProvider.notifier).state = languageToLocale(state.language);
    ref.invalidate(homeProvider);
    state = state.copyWith(isSaving: false);
  }

  Future<void> clearAll() async {
    final prefs = ref.read(preferencesProvider);
    await prefs.clearAll();
    ref.invalidate(homeProvider);
  }
}

final profileProvider = NotifierProvider<ProfileNotifier, ProfileState>(
  ProfileNotifier.new,
);
