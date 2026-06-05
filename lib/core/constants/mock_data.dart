import '../../data/models/app_language.dart';
import '../../data/models/category.dart';
import '../../data/models/center.dart';
import '../../data/models/event.dart';
import '../../data/models/event_category.dart';

// ─── Centres ODEJ ────────────────────────────────────────────────────────────

final List<Center> kMockCenters = [
  Center(
    id: 'center_alger',
    name: 'ODEJ Alger-Centre',
    city: 'Alger',
    address: 'Rue Didouche Mourad, Alger-Centre',
    lat: 36.7372,
    lng: 3.0864,
    phone: '+213 21 63 00 00',
    hours: 'Dim–Jeu 8h–17h',
    createdAt: DateTime(2024, 1, 1),
  ),
  Center(
    id: 'center_blida',
    name: 'ODEJ Blida',
    city: 'Blida',
    address: 'Boulevard Colonel Lotfi, Blida',
    lat: 36.4728,
    lng: 2.8277,
    phone: '+213 25 41 00 00',
    hours: 'Dim–Jeu 8h–16h30',
    createdAt: DateTime(2024, 1, 1),
  ),
  Center(
    id: 'center_oran',
    name: 'ODEJ Oran',
    city: 'Oran',
    address: 'Rue Larbi Ben M\'hidi, Oran',
    lat: 35.6911,
    lng: -0.6417,
    phone: '+213 41 39 00 00',
    hours: 'Dim–Jeu 8h–17h',
    createdAt: DateTime(2024, 1, 1),
  ),
];

// ─── Événements ───────────────────────────────────────────────────────────────

final List<Event> kMockEvents = [
  Event(
    id: 'event_1',
    title: 'Hackathon Tech Jeunesse 2026',
    description:
        'Un hackathon de 48h pour les jeunes développeurs et designers.'
        ' Thème : solutions numériques pour les services publics locaux.'
        ' Équipes de 3 à 5 personnes. Prix et certificats pour les lauréats.',
    city: 'Alger',
    category: EventCategory.formation,
    dateStart: DateTime(2026, 6, 20, 9, 0),
    dateEnd: DateTime(2026, 6, 21, 18, 0),
    centerId: 'center_alger',
    isFree: true,
    imageUrl: null,
    lang: AppLanguage.fr,
    createdAt: DateTime(2026, 6, 1),
  ),
  Event(
    id: 'event_2',
    title: 'Tournoi de Football Interwilaya',
    description:
        'Compétition de football ouverte aux jeunes de 16 à 25 ans.'
        ' Phases de groupes sur deux jours, finale le dimanche.'
        ' Inscription par équipe de 11 joueurs + 3 remplaçants.',
    city: 'Blida',
    category: EventCategory.sport,
    dateStart: DateTime(2026, 6, 27, 8, 0),
    dateEnd: DateTime(2026, 6, 28, 18, 0),
    centerId: 'center_blida',
    isFree: true,
    imageUrl: null,
    lang: AppLanguage.fr,
    createdAt: DateTime(2026, 6, 2),
  ),
  Event(
    id: 'event_3',
    title: 'Festival de Musique Traditionnelle',
    description:
        'Soirée culturelle mettant en valeur la musique andalouse,'
        ' chaabi et kabyle. Artistes locaux et nationaux.'
        ' Entrée symbolique pour soutenir les artistes.',
    city: 'Oran',
    category: EventCategory.culture,
    dateStart: DateTime(2026, 7, 4, 19, 0),
    dateEnd: DateTime(2026, 7, 4, 23, 0),
    centerId: 'center_oran',
    isFree: false,
    imageUrl: null,
    lang: AppLanguage.fr,
    createdAt: DateTime(2026, 6, 3),
  ),
  Event(
    id: 'event_4',
    title: 'Journée Verte — Nettoyage du Parc',
    description:
        'Action citoyenne de nettoyage du parc municipal.'
        ' Matériel fourni sur place. Ouvert à tous, familles bienvenues.'
        ' Goûter offert aux bénévoles en fin de journée.',
    city: 'Alger',
    category: EventCategory.ecologie,
    dateStart: DateTime(2026, 7, 10, 8, 0),
    dateEnd: DateTime(2026, 7, 10, 13, 0),
    centerId: 'center_alger',
    isFree: true,
    imageUrl: null,
    lang: AppLanguage.fr,
    createdAt: DateTime(2026, 6, 4),
  ),
  Event(
    id: 'event_5',
    title: 'Atelier Entrepreneuriat Jeune',
    description:
        'Formation de 3 jours sur les bases de la création d\'entreprise :'
        ' idéation, business plan, financement et pitch.'
        ' Animé par des entrepreneurs locaux. Attestation de participation.',
    city: 'Blida',
    category: EventCategory.formation,
    dateStart: DateTime(2026, 7, 14, 9, 0),
    dateEnd: DateTime(2026, 7, 16, 17, 0),
    centerId: 'center_blida',
    isFree: false,
    imageUrl: null,
    lang: AppLanguage.fr,
    createdAt: DateTime(2026, 6, 5),
  ),
];

// ─── Catégories ───────────────────────────────────────────────────────────────

const List<Category> kCategories = [
  Category(
    id: EventCategory.formation,
    nameFr: 'Formation',
    nameAr: 'تكوين',
    nameTz: 'Tazrawt',
    icon: 'school',
  ),
  Category(
    id: EventCategory.sport,
    nameFr: 'Sport',
    nameAr: 'رياضة',
    nameTz: 'Aḍaddi',
    icon: 'sports_soccer',
  ),
  Category(
    id: EventCategory.culture,
    nameFr: 'Culture',
    nameAr: 'ثقافة',
    nameTz: 'Tameddurt',
    icon: 'theater_comedy',
  ),
  Category(
    id: EventCategory.ecologie,
    nameFr: 'Écologie',
    nameAr: 'بيئة',
    nameTz: 'Tamurt',
    icon: 'eco',
  ),
  Category(
    id: EventCategory.volontariat,
    nameFr: 'Volontariat',
    nameAr: 'تطوع',
    nameTz: 'Tawuri',
    icon: 'volunteer_activism',
  ),
];
