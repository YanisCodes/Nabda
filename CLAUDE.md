# OTEJ Link — Instructions pour Claude

## Contexte du projet

Application mobile Flutter offline-first pour les jeunes algériens.
Projet solo.
Lire `spec.md` et `todo.md` avant toute modification.
Lire `graphify-out/GRAPH_REPORT.md` avant de coder.
Ouvrir `graphify-out/graph.html` si une vue visuelle aide à comprendre la structure.
Lire les fichiers détaillés dans `graphify-out/` seulement si nécessaire.

## Objectif

Construire un MVP léger qui connecte les jeunes aux opportunités ODEJ :

- événements
- formations
- centres
- volontariat
- activités locales

## Stack

- Flutter 3.x, Dart
- Riverpod pour l’état
- Drift pour SQLite local
- Supabase uniquement pour la phase backend/admin
- flutter_map + OpenStreetMap pour la carte

## Architecture

```text
lib/
  core/
    theme/
    constants/
    utils/
  data/
    local/
    remote/
    models/
    sync/
  features/
    onboarding/
    home/
    explore/
    event_detail/
    map/
    profile/
  l10n/
```

Règle : chaque feature garde ses propres fichiers (`*_screen.dart`, `*_provider.dart`, `*_widget.dart`).
Pas de God files.

## Conventions

- Noms de fichiers en `snake_case`.
- Classes en `PascalCase`.
- Variables en `camelCase`.
- Providers Riverpod proches de leur feature.
- Pas de `print()` en production.
- Texte UI via `AppLocalizations` uniquement.
- Images via `CachedNetworkImage` seulement.

## Règles Green Tech

- Lire SQLite avant le réseau.
- Sync seulement si `last_sync > 24h`.
- Pas de `Timer.periodic`.
- Pas de background fetch inutile.
- Pas de dépendances non justifiées.
- Images WebP, légères, sous 50KB si possible.

## Approche de dev

1. Données statiques d’abord.
2. SQLite ensuite.
3. Supabase en dernier.

Toujours afficher quelque chose avant d’ajouter l’API.

## Context navigation

Quand tu dois comprendre le projet :

1. Lire d’abord `graphify-out/GRAPH_REPORT.md`.
2. Ouvrir `graphify-out/graph.html` si la structure visuelle aide.
3. Lire les fichiers bruts seulement si nécessaire.
4. Ne pas recharger tout le projet si le graphe suffit.

## Interdictions

- Pas de features hors MVP sans accord.
- Pas de logique métier dans les widgets.
- Pas de `setState` dans les écrans complexes.
- Pas d’abstraction prématurée.
- Pas de fichiers utilitaires fourre-tout.

## Fichiers clés

- `spec.md` : périmètre et architecture.
- `todo.md` : tâches en cours.
- `graphify-out/` : contexte visuel et structure du projet.
- `lib/core/constants/` : source de vérité des configs.

## Environnement

- Android en priorité.
- Mode sombre par défaut.
- Texte lisible, min 14sp.
- Langues : français par défaut, arabe RTL, tamazight.
