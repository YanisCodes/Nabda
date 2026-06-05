import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/theme/app_theme.dart';
import 'data/local/database.dart';
import 'data/local/data_providers.dart';
import 'data/local/preferences.dart';
import 'features/home/home_screen.dart';
import 'features/onboarding/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final sharedPrefs = await SharedPreferences.getInstance();
  final preferences = Preferences(sharedPrefs);

  // Ouvrir la base, insérer les données mockées si vide
  final db = AppDatabase();
  await db.seedIfEmpty();

  // Précharger en mémoire — les providers filtrent en Dart, sans requête supplémentaire
  final allEvents = await db.eventsDao.getAllModels();
  final allCenters = await db.centersDao.getAllModels();

  runApp(
    ProviderScope(
      overrides: [
        preferencesProvider.overrideWithValue(preferences),
        databaseProvider.overrideWithValue(db),
        eventsListProvider.overrideWith((_) => allEvents),
        centersListProvider.overrideWith((_) => allCenters),
      ],
      child: const OtejApp(),
    ),
  );
}

class OtejApp extends ConsumerWidget {
  const OtejApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.read(preferencesProvider);

    return MaterialApp(
      title: 'OTEJ Link',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      home: prefs.isFirstLaunch
          ? const OnboardingScreen()
          : const HomeScreen(),
    );
  }
}
