# Graph Report - nabda-better  (2026-06-05)

## Corpus Check
- 64 files · ~23,244 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 525 nodes · 607 edges · 43 communities (34 shown, 9 thin omitted)
- Extraction: 98% EXTRACTED · 2% INFERRED · 0% AMBIGUOUS · INFERRED: 13 edges (avg confidence: 0.86)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `2d858219`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- [[_COMMUNITY_Windows Desktop Runner|Windows Desktop Runner]]
- [[_COMMUNITY_OTEJ Link Product & Architecture|OTEJ Link Product & Architecture]]
- [[_COMMUNITY_Linux GTK Plugin Registry|Linux GTK Plugin Registry]]
- [[_COMMUNITY_Dark Theme System|Dark Theme System]]
- [[_COMMUNITY_Cross-Platform App Icons|Cross-Platform App Icons]]
- [[_COMMUNITY_Flutter App Entry Point|Flutter App Entry Point]]
- [[_COMMUNITY_iOS  macOS AppDelegate|iOS / macOS AppDelegate]]
- [[_COMMUNITY_Windows Runner Utilities|Windows Runner Utilities]]
- [[_COMMUNITY_PWA Web Manifest|PWA Web Manifest]]
- [[_COMMUNITY_Windows Flutter Window|Windows Flutter Window]]
- [[_COMMUNITY_macOS Plugin Registry|macOS Plugin Registry]]
- [[_COMMUNITY_Platform Test Suites|Platform Test Suites]]
- [[_COMMUNITY_Android Launcher Icons|Android Launcher Icons]]
- [[_COMMUNITY_iOS LLDB Debug Helper|iOS LLDB Debug Helper]]
- [[_COMMUNITY_iOS AppIcon Metadata|iOS AppIcon Metadata]]
- [[_COMMUNITY_iOS LaunchImage Metadata|iOS LaunchImage Metadata]]
- [[_COMMUNITY_macOS AppIcon Metadata|macOS AppIcon Metadata]]
- [[_COMMUNITY_Android Plugin Registry|Android Plugin Registry]]
- [[_COMMUNITY_Windows FlutterWindow Header|Windows FlutterWindow Header]]
- [[_COMMUNITY_Claude Code Permissions|Claude Code Permissions]]
- [[_COMMUNITY_Windows Plugin Registry|Windows Plugin Registry]]
- [[_COMMUNITY_Android Main Activity|Android Main Activity]]
- [[_COMMUNITY_iOS Plugin Registry|iOS Plugin Registry]]
- [[_COMMUNITY_Linux Build Config|Linux Build Config]]
- [[_COMMUNITY_Windows Build Config|Windows Build Config]]
- [[_COMMUNITY_Misc Platform Code|Misc Platform Code]]
- [[_COMMUNITY_Misc Platform Code|Misc Platform Code]]
- [[_COMMUNITY_Misc Platform Code|Misc Platform Code]]
- [[_COMMUNITY_Misc Platform Code|Misc Platform Code]]
- [[_COMMUNITY_Misc Platform Code|Misc Platform Code]]
- [[_COMMUNITY_Misc Platform Code|Misc Platform Code]]
- [[_COMMUNITY_Community 39|Community 39]]
- [[_COMMUNITY_Community 40|Community 40]]
- [[_COMMUNITY_Community 41|Community 41]]

## God Nodes (most connected - your core abstractions)
1. `OTEJ Link — Projet personnel` - 18 edges
2. `OTEJ Link — Todo MVP` - 14 edges
3. `OTEJ Link — Instructions pour Claude` - 12 edges
4. `_` - 12 edges
5. `OTEJ Link — Spec MVP` - 11 edges
6. `Create()` - 10 edges
7. `MessageHandler()` - 10 edges
8. `WndProc()` - 9 edges
9. `Fonctionnalités principales` - 8 edges
10. `preferencesProvider` - 7 edges

## Surprising Connections (you probably didn't know these)
- `wWinMain()` --calls--> `CreateAndAttachConsole()`  [INFERRED]
  windows/runner/main.cpp → windows/runner/utils.cpp
- `build` --references--> `preferencesProvider`  [EXTRACTED]
  lib/features/home/home_screen.dart → lib/data/local/preferences.dart
- `_HomePlaceholder` --references--> `preferencesProvider`  [EXTRACTED]
  lib/features/home/home_screen.dart → lib/data/local/preferences.dart
- `build` --references--> `preferencesProvider`  [EXTRACTED]
  lib/main.dart → lib/data/local/preferences.dart
- `complete` --references--> `preferencesProvider`  [EXTRACTED]
  lib/features/onboarding/onboarding_provider.dart → lib/data/local/preferences.dart

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **Offline-First Data Flow: SQLite read first, delta sync from Supabase when stale, tracked by SyncMeta** — drift_sqlite_local_db, supabase_backend_service, sync_service_logic, model_syncmeta [EXTRACTED 0.95]
- **MVP 6-Screen Feature Set: Onboarding, Home, Explore, EventDetail, Map, Profile** — feature_onboarding, feature_home, feature_explore, feature_event_detail, feature_map_centers, feature_profile [EXTRACTED 1.00]
- **Multilingual Stack: l10n.yaml configures flutter_localizations ARB generation, profile screen exposes language switch** — multilingual_i18n, l10n_yaml, feature_profile [INFERRED 0.85]
- **Android Launcher Icon Set (all densities: mdpi/hdpi/xhdpi/xxhdpi/xxxhdpi)** — mipmap_mdpi_ic_launcher, mipmap_hdpi_ic_launcher, mipmap_xhdpi_ic_launcher, mipmap_xxhdpi_ic_launcher, mipmap_xxxhdpi_ic_launcher [EXTRACTED 1.00]
- **iOS AppIcon.appiconset (all sizes)** — ios_icon_app_1024x1024_1x, ios_icon_app_20x20_1x, ios_icon_app_20x20_2x, ios_icon_app_40x40_1x, ios_icon_app_60x60_2x [EXTRACTED 1.00]
- **iOS LaunchImage.imageset (1x/2x/3x)** — ios_launchimage, ios_launchimage_2x, ios_launchimage_3x [EXTRACTED 1.00]
- **macOS AppIcon.appiconset (128/256/512/1024px)** — macos_app_icon_128, macos_app_icon_256, macos_app_icon_512, macos_app_icon_1024 [EXTRACTED 1.00]
- **Web PWA Icons (favicon + 192/512 standard + 192/512 maskable)** — web_favicon, web_icon_192, web_icon_512, web_icon_maskable_192, web_icon_maskable_512 [EXTRACTED 1.00]
- **All Flutter Default Boilerplate Icons Across All Platforms** — mipmap_mdpi_ic_launcher, mipmap_hdpi_ic_launcher, mipmap_xhdpi_ic_launcher, mipmap_xxhdpi_ic_launcher, mipmap_xxxhdpi_ic_launcher, ios_icon_app_1024x1024_1x, ios_icon_app_20x20_1x, ios_icon_app_20x20_2x, ios_icon_app_40x40_1x, ios_icon_app_60x60_2x, ios_launchimage, ios_launchimage_2x, ios_launchimage_3x, macos_app_icon_128, macos_app_icon_256, macos_app_icon_512, macos_app_icon_1024, web_favicon, web_icon_192, web_icon_512, web_icon_maskable_192, web_icon_maskable_512 [INFERRED 0.95]

## Communities (43 total, 9 thin omitted)

### Community 0 - "Windows Desktop Runner"
Cohesion: 0.09
Nodes (34): RegisterPlugins(), PluginRegistry, Point, RECT, OnCreate(), Create(), Destroy(), EnableFullDpiSupportIfAvailable() (+26 more)

### Community 1 - "OTEJ Link Product & Architecture"
Cohesion: 0.05
Nodes (42): ../../core/constants/mock_data.dart, Event, exploreProvider, build, _CategoryChips, _Chip, _EmptyState, ExploreScreen (+34 more)

### Community 2 - "Linux GTK Plugin Registry"
Cohesion: 0.11
Nodes (22): FlPluginRegistry, fl_register_plugins(), FlView, GApplication, gboolean, gchar, GObject, GtkApplication (+14 more)

### Community 3 - "Dark Theme System"
Cohesion: 0.08
Nodes (24): static const Color, static const TextTheme, static ThemeData get, amber, amberDark, AppColors, AppTheme, bgDark (+16 more)

### Community 4 - "Cross-Platform App Icons"
Cohesion: 0.33
Nodes (6): Android Launcher Icons Group, Flutter Default Launcher Icons (Boilerplate Blue Flutter Logo), iOS App Icons Group, iOS Launch Images Group, macOS App Icons Group, Web App Icons Group

### Community 5 - "Flutter App Entry Point"
Cohesion: 0.05
Nodes (42): AppLanguage get, core/theme/app_theme.dart, data/local/preferences.dart, ../explore/explore_screen.dart, features/home/home_screen.dart, features/onboarding/onboarding_screen.dart, build, createState (+34 more)

### Community 6 - "iOS / macOS AppDelegate"
Cohesion: 0.18
Nodes (8): Any, FlutterAppDelegate, Bool, AppDelegate, Bool, AppDelegate, NSApplication, UIApplication

### Community 7 - "Windows Runner Utilities"
Cohesion: 0.23
Nodes (9): _In_, _In_opt_, wWinMain(), CreateAndAttachConsole(), GetCommandLineArguments(), Utf8FromUtf16(), vector, string (+1 more)

### Community 8 - "PWA Web Manifest"
Cohesion: 0.18
Nodes (10): background_color, description, display, icons, name, orientation, prefer_related_applications, short_name (+2 more)

### Community 9 - "Windows Flutter Window"
Cohesion: 0.22
Nodes (8): DartProject, MessageHandler(), HWND, LPARAM, LRESULT, FlutterWindow(), UINT, WPARAM

### Community 10 - "macOS Plugin Registry"
Cohesion: 0.29
Nodes (4): RegisterGeneratedPlugins(), FlutterPluginRegistry, NSWindow, MainFlutterWindow

### Community 11 - "Platform Test Suites"
Cohesion: 0.29
Nodes (3): RunnerTests, RunnerTests, XCTestCase

### Community 12 - "Android Launcher Icons"
Cohesion: 0.07
Nodes (34): bool get, ConsumerWidget, ../../core/constants/wilayas.dart, fr,
  ar,, ../home/home_screen.dart, _HomePlaceholder, AppLanguage, code (+26 more)

### Community 13 - "iOS LLDB Debug Helper"
Cohesion: 0.33
Nodes (5): handle_new_rx_page(), __lldb_init_module(), Intercept NOTIFY_DEBUGGER_ABOUT_RX_PAGES and touch the pages., SBDebugger, SBFrame

### Community 14 - "iOS AppIcon Metadata"
Cohesion: 0.40
Nodes (4): images, info, author, version

### Community 15 - "iOS LaunchImage Metadata"
Cohesion: 0.40
Nodes (4): images, info, author, version

### Community 16 - "macOS AppIcon Metadata"
Cohesion: 0.40
Nodes (4): images, info, author, version

### Community 20 - "Windows Plugin Registry"
Cohesion: 0.06
Nodes (31): app_language.dart, event_category.dart, formation,
  sport,
  culture,
  ecologie,, category, Category, icon, id, localizedName (+23 more)

### Community 23 - "Linux Build Config"
Cohesion: 0.07
Nodes (29): 1. Accueil intelligent, 2. Explorer les opportunités, 3. Carte interactive, 4. Profil utilisateur, 5. Volontariat et engagement, 6. Notifications légères, 7. Interface ODEJ pour mise à jour, Admin dashboard (+21 more)

### Community 24 - "Windows Build Config"
Cohesion: 0.09
Nodes (25): app_localizations.dart, app_localizations_fr.dart, dart:async, AppLocalizations, _AppLocalizationsDelegate, appName, delegate, AppLocalizationsFr (+17 more)

### Community 25 - "Misc Platform Code"
Cohesion: 0.08
Nodes (24): kCategories, kMockCenters, kMockEvents, code, kWilayas, nameAr, nameFr, toString (+16 more)

### Community 31 - "Misc Platform Code"
Cohesion: 0.09
Nodes (21): Accueil, Architecture, Carte centres, `categories`, Ce qui n'est PAS dans le MVP, `centers` (centres ODEJ), Contraintes Green Tech, Détail événement (+13 more)

### Community 35 - "Misc Platform Code"
Cohesion: 0.11
Nodes (17): DateTime, int get, address, Center, city, copyWith, createdAt, fromJson (+9 more)

### Community 37 - "Misc Platform Code"
Cohesion: 0.13
Nodes (14): Backlog v2 (hors MVP), OTEJ Link — Todo MVP, PHASE 10 — Supabase (réseau), PHASE 11 — Multilingue, PHASE 12 — Polish et Green Tech audit, PHASE 1 — Fondations (projet vide → premier écran visible), PHASE 2 — Modèles et données statiques, PHASE 3 — Onboarding (feature la plus simple) (+6 more)

### Community 39 - "Community 39"
Cohesion: 0.15
Nodes (12): Approche de dev, Architecture, Context navigation, Contexte du projet, Conventions, Environnement, Fichiers clés, Interdictions (+4 more)

## Knowledge Gaps
- **267 isolated node(s):** `Contexte du projet`, `Objectif`, `Stack`, `Architecture`, `Conventions` (+262 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **9 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `EventCategory` connect `Windows Plugin Registry` to `Misc Platform Code`, `OTEJ Link Product & Architecture`?**
  _High betweenness centrality (0.052) - this node is a cross-community bridge._
- **Why does `AppLanguage` connect `Android Launcher Icons` to `Windows Plugin Registry`?**
  _High betweenness centrality (0.042) - this node is a cross-community bridge._
- **What connects `Contexte du projet`, `Objectif`, `Stack` to the rest of the system?**
  _268 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Windows Desktop Runner` be split into smaller, more focused modules?**
  _Cohesion score 0.08658536585365853 - nodes in this community are weakly interconnected._
- **Should `OTEJ Link Product & Architecture` be split into smaller, more focused modules?**
  _Cohesion score 0.05391120507399577 - nodes in this community are weakly interconnected._
- **Should `Linux GTK Plugin Registry` be split into smaller, more focused modules?**
  _Cohesion score 0.10666666666666667 - nodes in this community are weakly interconnected._
- **Should `Dark Theme System` be split into smaller, more focused modules?**
  _Cohesion score 0.08 - nodes in this community are weakly interconnected._