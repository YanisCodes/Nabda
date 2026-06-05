# Graph Report - .  (2026-06-05)

## Corpus Check
- Corpus is ~19,395 words - fits in a single context window. You may not need a graph.

## Summary
- 284 nodes · 358 edges · 39 communities (27 shown, 12 thin omitted)
- Extraction: 88% EXTRACTED · 12% INFERRED · 0% AMBIGUOUS · INFERRED: 43 edges (avg confidence: 0.88)
- Token cost: 12,500 input · 3,800 output

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

## God Nodes (most connected - your core abstractions)
1. `spec.md — OTEJ Link MVP Specification` - 20 edges
2. `todo.md — MVP Development Task List` - 12 edges
3. `Create()` - 10 edges
4. `MessageHandler()` - 10 edges
5. `CLAUDE.md — Project Instructions for Claude` - 10 edges
6. `WndProc()` - 9 edges
7. `_MyApplication` - 7 edges
8. `HWND` - 7 edges
9. `WindowClassRegistrar` - 7 edges
10. `Destroy()` - 7 edges

## Surprising Connections (you probably didn't know these)
- `ic_launcher.png (Android mipmap-hdpi, ~72dp)` --semantically_similar_to--> `ic_launcher.png (Android mipmap-mdpi, ~48dp)`  [INFERRED] [semantically similar]
  C:/Users/HP/Desktop/school ts 2/projects/nabda-better/android/app/src/main/res/mipmap-hdpi/ic_launcher.png → C:/Users/HP/Desktop/school ts 2/projects/nabda-better/android/app/src/main/res/mipmap-mdpi/ic_launcher.png
- `ic_launcher.png (Android mipmap-hdpi, ~72dp)` --semantically_similar_to--> `ic_launcher.png (Android mipmap-xhdpi, ~96dp)`  [INFERRED] [semantically similar]
  C:/Users/HP/Desktop/school ts 2/projects/nabda-better/android/app/src/main/res/mipmap-hdpi/ic_launcher.png → C:/Users/HP/Desktop/school ts 2/projects/nabda-better/android/app/src/main/res/mipmap-xhdpi/ic_launcher.png
- `ic_launcher.png (Android mipmap-hdpi, ~72dp)` --semantically_similar_to--> `ic_launcher.png (Android mipmap-xxhdpi, ~144dp)`  [INFERRED] [semantically similar]
  C:/Users/HP/Desktop/school ts 2/projects/nabda-better/android/app/src/main/res/mipmap-hdpi/ic_launcher.png → C:/Users/HP/Desktop/school ts 2/projects/nabda-better/android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png
- `ic_launcher.png (Android mipmap-hdpi, ~72dp)` --semantically_similar_to--> `ic_launcher.png (Android mipmap-xxxhdpi, ~192dp)`  [INFERRED] [semantically similar]
  C:/Users/HP/Desktop/school ts 2/projects/nabda-better/android/app/src/main/res/mipmap-hdpi/ic_launcher.png → C:/Users/HP/Desktop/school ts 2/projects/nabda-better/android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png
- `OnCreate()` --calls--> `RegisterPlugins()`  [INFERRED]
  windows/runner/flutter_window.cpp → windows/flutter/generated_plugin_registrant.cc

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

## Communities (39 total, 12 thin omitted)

### Community 0 - "Windows Desktop Runner"
Cohesion: 0.10
Nodes (32): Point, RECT, OnCreate(), Create(), Destroy(), EnableFullDpiSupportIfAvailable(), GetClientArea(), GetHandle() (+24 more)

### Community 1 - "OTEJ Link Product & Architecture"
Cohesion: 0.18
Nodes (29): ODEJ Admin Dashboard — Content Management Without Code, CachedNetworkImage — Automatic Image Caching, No Re-download, CLAUDE.md — Project Instructions for Claude, Drift SQLite Local Database, Event Detail Feature — Full Info + Contact Button + Map Link, Explore Feature — Filtered Event List by Category/City/Date, Home Feature — Upcoming Events by City + Nearby Centers + Quick Nav, Map Centers Feature — flutter_map with ODEJ Center Pins + BottomSheet (+21 more)

### Community 2 - "Linux GTK Plugin Registry"
Cohesion: 0.11
Nodes (22): FlPluginRegistry, fl_register_plugins(), FlView, GApplication, gboolean, gchar, GObject, GtkApplication (+14 more)

### Community 3 - "Dark Theme System"
Cohesion: 0.08
Nodes (24): static const Color, static const TextTheme, static ThemeData get, amber, amberDark, AppColors, AppTheme, bgDark (+16 more)

### Community 4 - "Cross-Platform App Icons"
Cohesion: 0.13
Nodes (22): Flutter Default Launcher Icons (Boilerplate Blue Flutter Logo), iOS App Icons Group, Icon-App-1024x1024@1x.png (iOS App Store icon), Icon-App-20x20@1x.png (iOS notification icon 1x), Icon-App-20x20@2x.png (iOS notification icon 2x), Icon-App-40x40@1x.png (iOS spotlight icon 1x), Icon-App-60x60@2x.png (iOS home screen icon 2x), iOS Launch Images Group (+14 more)

### Community 5 - "Flutter App Entry Point"
Cohesion: 0.16
Nodes (13): core/theme/app_theme.dart, _AppLogo, build, main, OtejApp, _SplashScreen, package:flutter/material.dart, package:flutter_riverpod/flutter_riverpod.dart (+5 more)

### Community 6 - "iOS / macOS AppDelegate"
Cohesion: 0.18
Nodes (8): Any, FlutterAppDelegate, Bool, AppDelegate, Bool, AppDelegate, NSApplication, UIApplication

### Community 7 - "Windows Runner Utilities"
Cohesion: 0.22
Nodes (9): _In_, _In_opt_, wWinMain(), CreateAndAttachConsole(), GetCommandLineArguments(), Utf8FromUtf16(), string, vector (+1 more)

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
Cohesion: 0.60
Nodes (6): Android Launcher Icons Group, ic_launcher.png (Android mipmap-hdpi, ~72dp), ic_launcher.png (Android mipmap-mdpi, ~48dp), ic_launcher.png (Android mipmap-xhdpi, ~96dp), ic_launcher.png (Android mipmap-xxhdpi, ~144dp), ic_launcher.png (Android mipmap-xxxhdpi, ~192dp)

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

### Community 23 - "Linux Build Config"
Cohesion: 0.67
Nodes (3): linux/CMakeLists.txt — Linux Root Build Config, linux/flutter/CMakeLists.txt — Linux Flutter Library Build, linux/runner/CMakeLists.txt — Linux Runner Build

### Community 24 - "Windows Build Config"
Cohesion: 0.67
Nodes (3): windows/CMakeLists.txt — Windows Root Build Config, windows/flutter/CMakeLists.txt — Windows Flutter Library Build, windows/runner/CMakeLists.txt — Windows Runner Build

## Knowledge Gaps
- **96 isolated node(s):** `allow`, `SBFrame`, `SBDebugger`, `flutter_export_environment.sh script`, `UIApplication` (+91 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **12 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `OnCreate()` connect `Windows Desktop Runner` to `Windows Flutter Window`, `Windows Plugin Registry`?**
  _High betweenness centrality (0.013) - this node is a cross-community bridge._
- **What connects `allow`, `SBFrame`, `SBDebugger` to the rest of the system?**
  _97 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Windows Desktop Runner` be split into smaller, more focused modules?**
  _Cohesion score 0.0953058321479374 - nodes in this community are weakly interconnected._
- **Should `Linux GTK Plugin Registry` be split into smaller, more focused modules?**
  _Cohesion score 0.10666666666666667 - nodes in this community are weakly interconnected._
- **Should `Dark Theme System` be split into smaller, more focused modules?**
  _Cohesion score 0.08 - nodes in this community are weakly interconnected._
- **Should `Cross-Platform App Icons` be split into smaller, more focused modules?**
  _Cohesion score 0.1341991341991342 - nodes in this community are weakly interconnected._