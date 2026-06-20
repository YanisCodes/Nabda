# OTEJ Link

A Flutter mobile app that connects Algerian youth to local ODEJ opportunities — events, training programs, volunteer work, and community centers — all available offline.

## Features

- **Browse events** by category: formations, sports, culture, ecology, volontariat
- **Explore by wilaya** — filter opportunities near you across all 58 wilayas
- **Offline-first** — content available without internet, synced in the background
- **Event reminders** — one-tap local notification 1 hour before an event starts
- **Favorites** — save events across sessions
- **Map view** — locate ODEJ centers on OpenStreetMap
- **Share & Calendar** — share events or add them to your device calendar
- **Multilingual** — French, Arabic (RTL), Tamazight

## Stack

| Layer | Tech |
|---|---|
| Framework | Flutter 3.x / Dart |
| State | Riverpod |
| Local DB | Drift (SQLite) |
| Backend | Supabase |
| Map | flutter_map + OpenStreetMap |
| Notifications | flutter_local_notifications |

## Architecture

```
lib/
  core/          # theme, constants, utils
  data/          # models, local DB, remote, sync
  features/      # one folder per screen
  l10n/          # ARB files — FR / AR / TZM
```

Each feature is self-contained (`*_screen.dart`, `*_provider.dart`, `*_widget.dart`). No god files.

## Getting started

```bash
flutter pub get
flutter run
```

Requires Flutter 3.x and an Android device or emulator (API 21+).

## Platform

Android (primary). Dark mode only.
