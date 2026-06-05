# OTEJ Link — Todo MVP

Stratégie : données statiques d'abord → SQLite → Supabase.
Un écran fonctionnel vaut mieux que trois écrans vides.

---

## PHASE 1 — Fondations (projet vide → premier écran visible)

- [x] **T01** Créer le projet Flutter : `flutter create otej_link --org com.otej`
- [x] **T02** Ajouter les dépendances dans `pubspec.yaml` : riverpod, drift, supabase_flutter, flutter_map, cached_network_image, flutter_localizations
- [x] **T03** Créer la structure de dossiers `lib/` telle que définie dans CLAUDE.md
- [x] **T04** Définir le thème dark dans `lib/core/theme/app_theme.dart` (couleurs, typo, thème Material)
- [x] **T05** Configurer `main.dart` : ProviderScope, MaterialApp avec thème dark, routing basique

**Livrable T01→T05 :** `flutter run` affiche un écran noir avec le bon thème.

---

## PHASE 2 — Modèles et données statiques

- [x] **T06** Créer les modèles Dart purs dans `lib/data/models/` : `Event`, `Center`, `Category`
- [x] **T07** Créer `lib/core/constants/mock_data.dart` avec 5 événements et 3 centres fictifs (Alger, Blida, Oran)
- [x] **T08** Créer `lib/core/constants/wilayas.dart` avec la liste des 58 wilayas

**Livrable T06→T08 :** données accessibles en Dart, aucune UI encore.

---

## PHASE 3 — Onboarding (feature la plus simple)

- [x] **T09** Créer `lib/data/local/preferences.dart` : lire/écrire ville + langue avec `shared_preferences`
- [x] **T10** Créer `lib/features/onboarding/onboarding_screen.dart` : sélecteur de ville (DropdownButton sur liste wilayas) + sélecteur de langue (3 boutons)
- [x] **T11** Créer `onboarding_provider.dart` : provider Riverpod qui lit/écrit les préférences et gère la navigation
- [x] **T12** Logique "first launch" dans `main.dart` : si préférences vides → Onboarding, sinon → Home

**Livrable T09→T12 :** onboarding complet, ville + langue sauvegardés, redirection correcte.

---

## PHASE 4 — Écran Explorer (données mockées)

*L'Explorer avant l'Accueil : plus simple car pas de logique "personnalisé", juste une liste filtrée.*

- [x] **T13** Créer `lib/features/explore/explore_provider.dart` : provider qui retourne les événements mockés filtrés par catégorie sélectionnée
- [x] **T14** Créer `lib/features/explore/explore_screen.dart` : liste d'événements avec chips de catégorie (Tout / Formation / Sport / Culture / Écologie / Volontariat)
- [x] **T15** Créer `lib/features/explore/widgets/event_card.dart` : carte événement (image placeholder + titre + date + ville + badge gratuit/payant)
- [x] **T16** Brancher les chips sur le provider : tap sur chip → filtre la liste instantanément

**Livrable T13→T16 :** liste d'événements mockés, filtres fonctionnels, aucun réseau.

---

## PHASE 5 — Détail événement

- [ ] **T17** Créer `lib/features/event_detail/event_detail_screen.dart` : affiche tous les champs d'un Event (image hero + titre + date + description + ville)
- [ ] **T18** Ajouter navigation Explorer → Détail (route avec l'objet Event)
- [ ] **T19** Bouton "Contacter" : `url_launcher` pour ouvrir un numéro de téléphone

**Livrable T17→T19 :** navigation complète Explorer → Détail → retour.

---

## PHASE 6 — Accueil

- [ ] **T20** Créer `lib/features/home/home_provider.dart` : provider qui filtre les événements par ville du profil + les 3 plus proches dans le temps
- [ ] **T21** Créer `lib/features/home/home_screen.dart` : bandeau ville, section "Cette semaine" (5 events max), section "Centres" (3 centers), boutons Explorer/Carte
- [ ] **T22** Créer `lib/features/home/widgets/section_header.dart` : header réutilisable avec titre + lien "Voir tout"

**Livrable T20→T22 :** accueil avec données filtrées par ville du profil.

---

## PHASE 7 — Profil

- [ ] **T23** Créer `lib/features/profile/profile_screen.dart` : affiche ville + langue, permet modification, bouton "Effacer données locales"
- [ ] **T24** Modification ville/langue : met à jour les préférences et rafraîchit l'accueil

**Livrable T23→T24 :** profil modifiable, changement de ville reflété sur l'accueil.

---

## PHASE 8 — Carte (centres ODEJ)

- [ ] **T25** Ajouter `flutter_map` + `latlong2` dans pubspec
- [ ] **T26** Créer `lib/features/map/map_screen.dart` : flutter_map centré sur la ville du profil, tiles OpenStreetMap
- [ ] **T27** Ajouter les markers des centres mockés sur la carte
- [ ] **T28** Tap sur marker → BottomSheet avec nom, adresse, horaires, téléphone

**Livrable T25→T28 :** carte fonctionnelle, centres visibles, aucun compte Google Maps requis.

---

## PHASE 9 — SQLite avec drift

- [ ] **T29** Créer `lib/data/local/database.dart` : tables Events, Centers, UserProfile avec drift
- [ ] **T30** Créer `lib/data/local/daos/events_dao.dart` et `centers_dao.dart`
- [ ] **T31** Seed initial : insérer les données mockées dans SQLite au premier lancement
- [ ] **T32** Brancher les providers Riverpod sur drift (remplace les listes mockées statiques)

**Livrable T29→T32 :** données persistantes localement, app fonctionne hors ligne.

---

## PHASE 10 — Supabase (réseau)

- [ ] **T33** Créer le projet Supabase, exécuter le SQL de création des tables (voir spec.md)
- [ ] **T34** Insérer 10 événements réels et 5 centres dans Supabase via le dashboard
- [ ] **T35** Créer `lib/data/remote/supabase_client.dart` et `lib/data/sync/sync_service.dart`
- [ ] **T36** Logique sync : au démarrage, si `last_sync > 24h` → fetch delta Supabase → upsert SQLite
- [ ] **T37** Pull-to-refresh sur l'accueil déclenche la sync manuellement

**Livrable T33→T37 :** données réelles, sync offline-first complète.

---

## PHASE 11 — Multilingue

- [ ] **T38** Configurer `flutter_localizations` dans `pubspec.yaml` et `main.dart`
- [ ] **T39** Créer `lib/l10n/app_fr.arb`, `app_ar.arb`, `app_tz.arb` avec toutes les chaînes UI
- [ ] **T40** Remplacer toutes les strings hardcodées par `AppLocalizations.of(context).xxx`
- [ ] **T41** Tester le RTL avec la langue arabe

**Livrable T38→T41 :** app complètement traduite, RTL fonctionnel en arabe.

---

## PHASE 12 — Polish et Green Tech audit

- [ ] **T42** Vérifier que toutes les images passent par `CachedNetworkImage`
- [ ] **T43** Compresser les assets locaux (icônes, images de test) en WebP < 50KB
- [ ] **T44** Profiler avec Flutter DevTools : pas de rebuild inutile, pas de leak mémoire
- [ ] **T45** Tester hors ligne complet : couper le réseau, vérifier que tout s'affiche
- [ ] **T46** Tester sur un vieux Android (API 21 minimum)

---

## Backlog v2 (hors MVP)

- [ ] Module volontariat (missions + heures)
- [ ] Notifications push (Firebase FCM)
- [ ] Authentification utilisateur (Supabase Auth)
- [ ] Inscriptions en ligne
- [ ] Statistiques de consultation (admin dashboard étendu)
- [ ] Export PDF attestation de volontariat

---

**Commencer par T01.** Ne pas sauter de phase.
