import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/app_language.dart';
import '../models/center.dart' as model;
import '../models/event.dart';
import 'preferences.dart';

/// Cache en mémoire chargé depuis SQLite au démarrage.
/// Mis à jour après une sync Supabase (Phase 10).
final eventsListProvider = StateProvider<List<Event>>((_) => const []);
final centersListProvider =
    StateProvider<List<model.Center>>((_) => const []);

/// Locale active — mise à jour quand l'utilisateur change de langue.
final localeProvider = StateProvider<Locale>((ref) {
  final prefs = ref.read(preferencesProvider);
  return languageToLocale(prefs.language);
});

/// Mappe l'enum interne AppLanguage vers un Locale Flutter.
/// AppLanguage.tz → Locale('tzm') (Central Atlas Tamazight, code IANA valide).
Locale languageToLocale(AppLanguage lang) => switch (lang) {
      AppLanguage.fr => const Locale('fr'),
      AppLanguage.ar => const Locale('ar'),
      AppLanguage.tz => const Locale('tzm'),
    };
