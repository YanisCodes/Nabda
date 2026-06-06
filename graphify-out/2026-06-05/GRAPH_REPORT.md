# Graph Report - nabda-better  (2026-06-05)

## Corpus Check
- 77 files · ~32,189 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 795 nodes · 1016 edges · 64 communities (53 shown, 11 thin omitted)
- Extraction: 99% EXTRACTED · 1% INFERRED · 0% AMBIGUOUS · INFERRED: 13 edges (avg confidence: 0.86)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `8801d487`
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
- [[_COMMUNITY_Community 43|Community 43]]
- [[_COMMUNITY_Community 44|Community 44]]
- [[_COMMUNITY_Community 45|Community 45]]
- [[_COMMUNITY_Community 46|Community 46]]
- [[_COMMUNITY_Community 47|Community 47]]
- [[_COMMUNITY_Community 48|Community 48]]
- [[_COMMUNITY_Community 49|Community 49]]
- [[_COMMUNITY_Community 50|Community 50]]
- [[_COMMUNITY_Community 51|Community 51]]
- [[_COMMUNITY_Community 52|Community 52]]
- [[_COMMUNITY_Community 53|Community 53]]
- [[_COMMUNITY_Community 54|Community 54]]
- [[_COMMUNITY_Community 55|Community 55]]
- [[_COMMUNITY_Community 56|Community 56]]
- [[_COMMUNITY_Community 57|Community 57]]
- [[_COMMUNITY_Community 58|Community 58]]
- [[_COMMUNITY_Community 59|Community 59]]
- [[_COMMUNITY_Community 60|Community 60]]
- [[_COMMUNITY_Community 61|Community 61]]
- [[_COMMUNITY_Community 62|Community 62]]
- [[_COMMUNITY_Community 63|Community 63]]

## God Nodes (most connected - your core abstractions)
1. `_` - 79 edges
2. `OTEJ Link — Projet personnel` - 18 edges
3. `OTEJ Link — Todo MVP` - 14 edges
4. `OTEJ Link — Instructions pour Claude` - 12 edges
5. `_` - 12 edges
6. `OTEJ Link — Spec MVP` - 11 edges
7. `Create()` - 10 edges
8. `MessageHandler()` - 10 edges
9. `WndProc()` - 9 edges
10. `profileProvider` - 8 edges

## Surprising Connections (you probably didn't know these)
- `wWinMain()` --calls--> `CreateAndAttachConsole()`  [INFERRED]
  windows/runner/main.cpp → windows/runner/utils.cpp
- `build` --references--> `eventsListProvider`  [EXTRACTED]
  lib/features/explore/explore_provider.dart → lib/data/local/data_providers.dart
- `selectCategory` --references--> `eventsListProvider`  [EXTRACTED]
  lib/features/explore/explore_provider.dart → lib/data/local/data_providers.dart
- `EventRowX` --extends--> `EventRow`  [EXTRACTED]
  lib/data/local/database.dart → lib/data/local/database.g.dart
- `CenterRowX` --extends--> `CenterRow`  [EXTRACTED]
  lib/data/local/database.dart → lib/data/local/database.g.dart

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

## Communities (64 total, 11 thin omitted)

### Community 0 - "Windows Desktop Runner"
Cohesion: 0.09
Nodes (34): RegisterPlugins(), PluginRegistry, Point, RECT, OnCreate(), Create(), Destroy(), EnableFullDpiSupportIfAvailable() (+26 more)

### Community 1 - "OTEJ Link Product & Architecture"
Cohesion: 0.14
Nodes (17): ../event_detail/event_detail_screen.dart, exploreProvider, build, _CategoryChips, _Chip, _EmptyState, ExploreScreen, isSelected (+9 more)

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
Cohesion: 0.12
Nodes (15): AppLanguage get, city, clearAll, isFirstLaunch, _kCity, _kLang, language, Preferences (+7 more)

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
Nodes (43): ConsumerWidget, ../../core/constants/wilayas.dart, ../home/home_screen.dart, HomeScreen, _HomeScreenState, onboardingProvider, build, _CityDropdown (+35 more)

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
Cohesion: 0.10
Nodes (19): app_language.dart, category, centerId, city, copyWith, createdAt, dateEnd, dateStart (+11 more)

### Community 23 - "Linux Build Config"
Cohesion: 0.07
Nodes (29): 1. Accueil intelligent, 2. Explorer les opportunités, 3. Carte interactive, 4. Profil utilisateur, 5. Volontariat et engagement, 6. Notifications légères, 7. Interface ODEJ pour mise à jour, Admin dashboard (+21 more)

### Community 24 - "Windows Build Config"
Cohesion: 0.09
Nodes (25): app_localizations.dart, app_localizations_fr.dart, dart:async, AppLocalizations, _AppLocalizationsDelegate, appName, delegate, AppLocalizationsFr (+17 more)

### Community 25 - "Misc Platform Code"
Cohesion: 0.05
Nodes (49): AppLanguage, code, kWilayas, nameAr, nameFr, toString, Wilaya, wilayaByName (+41 more)

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

### Community 43 - "Community 43"
Cohesion: 0.10
Nodes (19): ../explore/explore_screen.dart, ../explore/widgets/event_card.dart, actionLabel, center, centers, city, createState, _currentIndex (+11 more)

### Community 44 - "Community 44"
Cohesion: 0.09
Nodes (28): _bgColor, build, category, _CategoryBadge, _CategoryHeader, center, _CenterCard, _CenterRow (+20 more)

### Community 45 - "Community 45"
Cohesion: 0.14
Nodes (13): Event, _bgColor, build, category, _CategoryBadge, event, EventCard, _formatDate (+5 more)

### Community 46 - "Community 46"
Cohesion: 0.03
Nodes (67): ColumnFilters, ColumnOrderings, GeneratedColumn, GeneratedDatabase, Iterable, _, address, category (+59 more)

### Community 47 - "Community 47"
Cohesion: 0.14
Nodes (13): data/local/database.dart, features/home/home_screen.dart, features/onboarding/onboarding_screen.dart, allCenters, allEvents, db, main, preferences (+5 more)

### Community 48 - "Community 48"
Cohesion: 0.18
Nodes (11): bool get, build, city, copyWith, isSaving, isValid, language, OnboardingNotifier (+3 more)

### Community 49 - "Community 49"
Cohesion: 0.22
Nodes (8): event_category.dart, Category, icon, id, localizedName, nameAr, nameFr, nameTz

### Community 50 - "Community 50"
Cohesion: 0.29
Nodes (6): core/theme/app_theme.dart, VoidCallback, build, onSeeAll, SectionHeader, title

### Community 51 - "Community 51"
Cohesion: 0.40
Nodes (4): package:flutter/material.dart, package:flutter_test/flutter_test.dart, package:otej_link/main.dart, main

### Community 52 - "Community 52"
Cohesion: 0.40
Nodes (4): formation,
  sport,
  culture,
  ecologie,, EventCategory, fromString, volontariat

### Community 53 - "Community 53"
Cohesion: 0.05
Nodes (37): BoolColumn get, CentersDao get, daos/centers_dao.dart, daos/events_dao.dart, DateTimeColumn get, EventsDao get, address, category (+29 more)

### Community 54 - "Community 54"
Cohesion: 0.08
Nodes (26): _, @DriftAccessor, @DriftDatabase, _$CentersDaoMixin, kCategories, kMockCenters, kMockEvents, CentersDao (+18 more)

### Community 55 - "Community 55"
Cohesion: 0.13
Nodes (14): IconData, _buildMarker, center, _CenterSheet, _dialPhone, icon, _initialView, _PinIcon (+6 more)

### Community 56 - "Community 56"
Cohesion: 0.25
Nodes (11): DataClass, Insertable, CenterRow, CenterRowX, CentersCompanion, EventRow, EventRowX, EventsCompanion (+3 more)

### Community 57 - "Community 57"
Cohesion: 0.25
Nodes (9): ../../core/constants/mock_data.dart, _, getCategories, getCenterById, getCenters, getEvents, MockRepository, ../models/category.dart (+1 more)

### Community 58 - "Community 58"
Cohesion: 0.33
Nodes (5): fr,
  ar,, AppLanguage, code, fromCode, tz

### Community 59 - "Community 59"
Cohesion: 0.60
Nodes (5): @DataClassName, Centers, Events, SyncMeta, Table

### Community 60 - "Community 60"
Cohesion: 0.40
Nodes (4): Center, ../models/center.dart, ../models/event.dart, package:flutter_riverpod/flutter_riverpod.dart

### Community 61 - "Community 61"
Cohesion: 0.50
Nodes (4): build, OtejApp, preferencesProvider, complete

## Knowledge Gaps
- **412 isolated node(s):** `getAllModels`, `getByCityModels`, `upsertAll`, `getAllModels`, `getByCityModels` (+407 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **11 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `_` connect `Community 46` to `Community 56`, `Misc Platform Code`, `Misc Platform Code`, `Windows Build Config`?**
  _High betweenness centrality (0.136) - this node is a cross-community bridge._
- **Why does `EventCategory` connect `Community 52` to `OTEJ Link Product & Architecture`, `Community 45`, `Community 49`, `Windows Plugin Registry`, `Misc Platform Code`?**
  _High betweenness centrality (0.033) - this node is a cross-community bridge._
- **Why does `AppLanguage` connect `Community 58` to `Community 48`, `Windows Plugin Registry`, `Android Launcher Icons`?**
  _High betweenness centrality (0.017) - this node is a cross-community bridge._
- **What connects `getAllModels`, `getByCityModels`, `upsertAll` to the rest of the system?**
  _413 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Windows Desktop Runner` be split into smaller, more focused modules?**
  _Cohesion score 0.08658536585365853 - nodes in this community are weakly interconnected._
- **Should `OTEJ Link Product & Architecture` be split into smaller, more focused modules?**
  _Cohesion score 0.13725490196078433 - nodes in this community are weakly interconnected._
- **Should `Linux GTK Plugin Registry` be split into smaller, more focused modules?**
  _Cohesion score 0.10666666666666667 - nodes in this community are weakly interconnected._