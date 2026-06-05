import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/theme/app_theme.dart';
import 'data/local/data_providers.dart';
import 'data/local/database.dart';
import 'data/local/preferences.dart';
import 'data/remote/supabase_client.dart';
import 'data/sync/sync_service.dart';
import 'features/home/home_screen.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final sharedPrefs = await SharedPreferences.getInstance();
  final preferences = Preferences(sharedPrefs);

  final db = AppDatabase();
  await db.seedIfEmpty();

  final allEvents = await db.eventsDao.getAllModels();
  final allCenters = await db.centersDao.getAllModels();

  // Initialiser Supabase si configuré
  await initSupabase();

  final container = ProviderContainer(
    overrides: [
      preferencesProvider.overrideWithValue(preferences),
      databaseProvider.overrideWithValue(db),
      eventsListProvider.overrideWith((_) => allEvents),
      centersListProvider.overrideWith((_) => allCenters),
    ],
  );

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const OtejApp(),
    ),
  );

  // Sync en arrière-plan après le premier frame — ne bloque pas l'UI
  WidgetsBinding.instance.addPostFrameCallback((_) {
    container.read(syncServiceProvider.notifier).syncIfStale();
  });
}

class OtejApp extends ConsumerWidget {
  const OtejApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.read(preferencesProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp(
      title: 'OTEJ Link',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: prefs.isFirstLaunch
          ? const OnboardingScreen()
          : const HomeScreen(),
    );
  }
}
