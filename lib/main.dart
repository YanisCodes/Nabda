import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/theme/app_theme.dart';
import 'data/local/data_providers.dart';
import 'data/local/database.dart';
import 'data/local/preferences.dart';
import 'data/remote/supabase_client.dart';
import 'data/sync/sync_service.dart';
import 'features/event_detail/notification_helper.dart';
import 'features/home/home_screen.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting(); // required by intl.DateFormat before first use
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

  await initNotifications();

  final container = ProviderContainer(
    overrides: [
      preferencesProvider.overrideWithValue(preferences),
      databaseProvider.overrideWithValue(db),
      eventsListProvider.overrideWith((_) => allEvents),
      centersListProvider.overrideWith((_) => allCenters),
    ],
  );

  runApp(
    UncontrolledProviderScope(container: container, child: const OtejApp()),
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
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        // tzm has no Material/Cupertino data upstream — fall back to French.
        _TzmFallbackMaterialDelegate(),
        _TzmFallbackWidgetsDelegate(),
        _TzmFallbackCupertinoDelegate(),
      ],
      supportedLocales: const [Locale('fr'), Locale('ar'), Locale('tzm')],
      home: prefs.isFirstLaunch ? const OnboardingScreen() : const HomeScreen(),
    );
  }
}

// ─── Fallback delegates for tzm ───────────────────────────────────────────────
// GlobalMaterial/Widgets/Cupertino don't ship Tamazight data. These delegates
// claim tzm and load the French data so that MaterialLocalizations and friends
// are always present in the widget tree.

class _TzmFallbackMaterialDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const _TzmFallbackMaterialDelegate();
  @override
  bool isSupported(Locale locale) => locale.languageCode == 'tzm';
  @override
  Future<MaterialLocalizations> load(Locale locale) =>
      GlobalMaterialLocalizations.delegate.load(const Locale('fr'));
  @override
  bool shouldReload(_TzmFallbackMaterialDelegate old) => false;
}

class _TzmFallbackWidgetsDelegate
    extends LocalizationsDelegate<WidgetsLocalizations> {
  const _TzmFallbackWidgetsDelegate();
  @override
  bool isSupported(Locale locale) => locale.languageCode == 'tzm';
  @override
  Future<WidgetsLocalizations> load(Locale locale) =>
      GlobalWidgetsLocalizations.delegate.load(const Locale('fr'));
  @override
  bool shouldReload(_TzmFallbackWidgetsDelegate old) => false;
}

class _TzmFallbackCupertinoDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const _TzmFallbackCupertinoDelegate();
  @override
  bool isSupported(Locale locale) => locale.languageCode == 'tzm';
  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      GlobalCupertinoLocalizations.delegate.load(const Locale('fr'));
  @override
  bool shouldReload(_TzmFallbackCupertinoDelegate old) => false;
}
