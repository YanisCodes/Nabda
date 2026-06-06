// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'OTEJ Link';

  @override
  String get onboardingSubtitle =>
      'Personnalisez votre expérience\npour découvrir les opportunités près de chez vous.';

  @override
  String get labelYourCity => 'Votre ville';

  @override
  String get hintSelectWilaya => 'Sélectionnez une wilaya';

  @override
  String get labelYourLanguage => 'Votre langue';

  @override
  String get btnStart => 'Commencer';

  @override
  String greetingWithCity(String city) {
    return 'Bonjour, $city !';
  }

  @override
  String get greetingNoCity => 'Bonjour !';

  @override
  String get homeSubtitle =>
      'Découvrez les opportunités ODEJ près de chez vous.';

  @override
  String homeSubtitleFallback(String city) {
    return 'Pas encore d\'événements à $city.\nVoici les prochains événements disponibles.';
  }

  @override
  String get sectionThisWeek => 'Cette semaine';

  @override
  String get sectionNearbyCenters => 'Centres proches';

  @override
  String get actionSeeAll => 'Voir tout';

  @override
  String get noEventsAvailable => 'Aucun événement disponible pour l\'instant.';

  @override
  String get btnExploreAll => 'Explorer tout';

  @override
  String get noCentersFound => 'Aucun centre trouvé.';

  @override
  String get navHome => 'Accueil';

  @override
  String get navExplore => 'Explorer';

  @override
  String get navMap => 'Carte';

  @override
  String get screenTitleExplore => 'Explorer';

  @override
  String get chipAll => 'Tout';

  @override
  String get noEventsInCategory => 'Aucun événement dans cette catégorie';

  @override
  String get sectionAbout => 'À propos';

  @override
  String get sectionOrganizerCenter => 'Centre organisateur';

  @override
  String get btnContactCenter => 'Contacter le centre';

  @override
  String get errorCantOpenPhone =>
      'Impossible d\'ouvrir l\'application téléphone';

  @override
  String get categoryFormation => 'Formation';

  @override
  String get categorySport => 'Sport';

  @override
  String get categoryCulture => 'Culture';

  @override
  String get categoryEcologie => 'Écologie';

  @override
  String get categoryVolontariat => 'Volontariat';

  @override
  String get labelFree => 'Gratuit';

  @override
  String get labelPaid => 'Payant';

  @override
  String get screenTitleProfile => 'Mon profil';

  @override
  String get btnSave => 'Enregistrer les modifications';

  @override
  String get sectionDangerZone => 'Zone de danger';

  @override
  String get btnClearData => 'Effacer les données locales';

  @override
  String get dialogClearTitle => 'Effacer les données ?';

  @override
  String get dialogClearContent =>
      'Votre ville et vos préférences seront supprimées. Vous serez redirigé vers l\'accueil de configuration.';

  @override
  String get actionCancel => 'Annuler';

  @override
  String get actionDelete => 'Effacer';

  @override
  String get screenTitleMap => 'Centres ODEJ';

  @override
  String get btnContact => 'Contacter';

  @override
  String get hintSearch => 'Rechercher un événement...';

  @override
  String get noSearchResults => 'Aucun résultat pour cette recherche.';

  @override
  String get btnViewOnMap => 'Voir sur la carte';

  @override
  String get filterAllCities => 'Toutes les villes';
}
