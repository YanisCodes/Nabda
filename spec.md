# OTEJ Link — Spec MVP

## Résumé

Application mobile Flutter offline-first qui connecte les jeunes algériens aux opportunités locales de l'ODEJ (événements, formations, centres, volontariat).

---

## MVP : périmètre strict

6 écrans, pas un de plus au départ.

| Écran | Ce qu'il fait |
|---|---|
| Onboarding | Choix ville + langue (stocké localement, affiché une seule fois) |
| Accueil | Liste courte : événements proches + centres proches |
| Explorer | Liste filtrée par ville / catégorie / date |
| Détail événement | Infos complètes + bouton contact |
| Carte centres | Carte statique avec pins des centres ODEJ |
| Profil | Ville, langue, centres d'intérêt (local uniquement) |

**Hors MVP (v2+) :** volontariat, notifications, statistiques admin, inscriptions en ligne.

---

## Architecture

```
[Flutter App]
     │
     ├─ lit d'abord : SQLite local (drift)
     │
     ├─ si connecté et données > 24h : sync Supabase
     │
     └─ affiche le résultat

[Supabase]
     ├─ PostgreSQL (source de vérité)
     ├─ REST API auto-générée
     ├─ Storage pour images
     └─ Dashboard = interface admin ODEJ (MVP)
```

**Pourquoi Supabase :** gratuit, API prête en 0 ligne de backend, dashboard intégré = admin ODEJ sans développement supplémentaire, Storage pour images compressées.

---

## Stack technique

| Couche | Choix | Raison |
|---|---|---|
| Mobile | Flutter 3.x | Demandé, Android-first |
| State management | Riverpod | Léger, simple, pas de boilerplate |
| DB locale | drift (SQLite) | Offline-first, type-safe |
| Backend | Supabase (free tier) | API + auth + storage + dashboard admin |
| Carte | flutter_map + OpenStreetMap | Gratuit, pas de clé API |
| Images | cached_network_image | Cache automatique, pas de re-téléchargement |

---

## Modèles de données

### `centers` (centres ODEJ)
```
id          uuid PK
name        text
city        text
address     text
lat         float
lng         float
phone       text
hours       text        -- "Lun-Ven 8h-17h"
created_at  timestamp
```

### `events`
```
id          uuid PK
title       text
description text
city        text
category    text        -- 'formation' | 'sport' | 'culture' | 'ecologie' | 'volontariat'
date_start  timestamp
date_end    timestamp
center_id   uuid FK → centers
is_free     bool
image_url   text
lang        text        -- 'fr' | 'ar' | 'tz'
created_at  timestamp
```

### `categories`
```
id    text PK          -- 'formation', 'sport', etc.
name_fr   text
name_ar   text
name_tz   text
icon      text         -- nom icône Material
```

### Local uniquement (drift, pas Supabase)
```
user_profile
  city        text
  language    text     -- 'fr' | 'ar' | 'tz'
  interests   text     -- JSON array

sync_meta
  table_name  text
  last_sync   timestamp
```

---

## Logique de synchronisation (offline-first)

1. Au démarrage : lire SQLite → afficher immédiatement
2. En arrière-plan : vérifier si dernière sync > 24h
3. Si oui ET connexion disponible : fetch Supabase (delta uniquement via `created_at > last_sync`)
4. Stocker en SQLite, rafraîchir l'UI
5. Si hors ligne : UI fonctionne normalement avec les données locales

**Pas de sync en temps réel.** Pas de websocket. Pas de background fetch automatique.

---

## Écrans détaillés

### Onboarding
- Page unique, affichée une seule fois
- Sélecteur de ville (liste fixe des wilayas algériennes)
- Sélecteur de langue (FR / AR / TZ)
- Bouton "Commencer" → stocke en local → redirige vers Accueil

### Accueil
- Bandeau : "Bonjour, [ville]"
- Section "Cette semaine" : 3-5 événements prochains filtrés par ville
- Section "Centres proches" : 3 centres avec distance approximative
- Boutons rapides : Explorer / Carte
- Pull-to-refresh déclenche la sync

### Explorer
- Barre de recherche (filtre textuel local)
- Chips de filtre : Tout / Formation / Sport / Culture / Écologie / Volontariat
- Filtre secondaire : ville (si différente du profil)
- Liste de cartes événement (image + titre + date + ville + gratuit/payant)
- Tri : date croissante par défaut

### Détail événement
- Image en-tête
- Titre, date, lieu, catégorie, gratuit/payant
- Description complète
- Bouton "Contacter le centre" → ouvre numéro de téléphone ou email
- Bouton "Voir le centre sur la carte"

### Carte centres
- flutter_map avec tiles OpenStreetMap
- Pins des centres ODEJ (chargés depuis SQLite)
- Tap sur un pin → bottom sheet avec nom, adresse, horaires, téléphone
- Centrage automatique sur la ville du profil

### Profil
- Ville actuelle (modifiable)
- Langue préférée (modifiable)
- Centres d'intérêt (checkboxes)
- Bouton "Effacer les données locales"
- Version de l'app

---

## Contraintes Green Tech

| Contrainte | Implémentation |
|---|---|
| Peu de requêtes réseau | Sync max 1x/24h, delta uniquement |
| Images légères | Compression Supabase < 50KB, format WebP |
| Cache local agressif | drift SQLite + cached_network_image |
| Pas de traitement inutile | Pas d'IA, pas de background service |
| UI économe | Dark mode par défaut, pas d'animation lourde |
| APK léger | Pas de dépendances inutiles, assets optimisés |

---

## Multilingue

- `flutter_localizations` + fichiers ARB (fr, ar, tz)
- Arabe : RTL activé automatiquement
- Tamazight : LTR, police Tifinagh si disponible sinon latin
- Langue par défaut : français

---

## Ce qui n'est PAS dans le MVP

- Inscriptions en ligne (juste "contacter le centre")
- Notifications push
- Authentification utilisateur
- Module volontariat
- Statistiques admin
- Partage social
- Commentaires / avis

Ces fonctionnalités arrivent en v2, après que le MVP soit stable et testé.
