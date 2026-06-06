import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_tzm.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('fr'),
    Locale('tzm'),
  ];

  /// Nom de l'application
  ///
  /// In fr, this message translates to:
  /// **'OTEJ Link'**
  String get appName;

  /// No description provided for @onboardingSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Personnalisez votre expérience\npour découvrir les opportunités près de chez vous.'**
  String get onboardingSubtitle;

  /// No description provided for @labelYourCity.
  ///
  /// In fr, this message translates to:
  /// **'Votre ville'**
  String get labelYourCity;

  /// No description provided for @hintSelectWilaya.
  ///
  /// In fr, this message translates to:
  /// **'Sélectionnez une wilaya'**
  String get hintSelectWilaya;

  /// No description provided for @labelYourLanguage.
  ///
  /// In fr, this message translates to:
  /// **'Votre langue'**
  String get labelYourLanguage;

  /// No description provided for @btnStart.
  ///
  /// In fr, this message translates to:
  /// **'Commencer'**
  String get btnStart;

  /// No description provided for @greetingWithCity.
  ///
  /// In fr, this message translates to:
  /// **'Bonjour, {city} !'**
  String greetingWithCity(String city);

  /// No description provided for @greetingNoCity.
  ///
  /// In fr, this message translates to:
  /// **'Bonjour !'**
  String get greetingNoCity;

  /// No description provided for @homeSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Découvrez les opportunités ODEJ près de chez vous.'**
  String get homeSubtitle;

  /// No description provided for @homeSubtitleFallback.
  ///
  /// In fr, this message translates to:
  /// **'Pas encore d\'événements à {city}.\nVoici les prochains événements disponibles.'**
  String homeSubtitleFallback(String city);

  /// No description provided for @sectionThisWeek.
  ///
  /// In fr, this message translates to:
  /// **'Cette semaine'**
  String get sectionThisWeek;

  /// No description provided for @sectionNearbyCenters.
  ///
  /// In fr, this message translates to:
  /// **'Centres proches'**
  String get sectionNearbyCenters;

  /// No description provided for @actionSeeAll.
  ///
  /// In fr, this message translates to:
  /// **'Voir tout'**
  String get actionSeeAll;

  /// No description provided for @noEventsAvailable.
  ///
  /// In fr, this message translates to:
  /// **'Aucun événement disponible pour l\'instant.'**
  String get noEventsAvailable;

  /// No description provided for @btnExploreAll.
  ///
  /// In fr, this message translates to:
  /// **'Explorer tout'**
  String get btnExploreAll;

  /// No description provided for @noCentersFound.
  ///
  /// In fr, this message translates to:
  /// **'Aucun centre trouvé.'**
  String get noCentersFound;

  /// No description provided for @navHome.
  ///
  /// In fr, this message translates to:
  /// **'Accueil'**
  String get navHome;

  /// No description provided for @navExplore.
  ///
  /// In fr, this message translates to:
  /// **'Explorer'**
  String get navExplore;

  /// No description provided for @navMap.
  ///
  /// In fr, this message translates to:
  /// **'Carte'**
  String get navMap;

  /// No description provided for @screenTitleExplore.
  ///
  /// In fr, this message translates to:
  /// **'Explorer'**
  String get screenTitleExplore;

  /// No description provided for @chipAll.
  ///
  /// In fr, this message translates to:
  /// **'Tout'**
  String get chipAll;

  /// No description provided for @noEventsInCategory.
  ///
  /// In fr, this message translates to:
  /// **'Aucun événement dans cette catégorie'**
  String get noEventsInCategory;

  /// No description provided for @sectionAbout.
  ///
  /// In fr, this message translates to:
  /// **'À propos'**
  String get sectionAbout;

  /// No description provided for @sectionOrganizerCenter.
  ///
  /// In fr, this message translates to:
  /// **'Centre organisateur'**
  String get sectionOrganizerCenter;

  /// No description provided for @btnContactCenter.
  ///
  /// In fr, this message translates to:
  /// **'Contacter le centre'**
  String get btnContactCenter;

  /// No description provided for @errorCantOpenPhone.
  ///
  /// In fr, this message translates to:
  /// **'Impossible d\'ouvrir l\'application téléphone'**
  String get errorCantOpenPhone;

  /// No description provided for @categoryFormation.
  ///
  /// In fr, this message translates to:
  /// **'Formation'**
  String get categoryFormation;

  /// No description provided for @categorySport.
  ///
  /// In fr, this message translates to:
  /// **'Sport'**
  String get categorySport;

  /// No description provided for @categoryCulture.
  ///
  /// In fr, this message translates to:
  /// **'Culture'**
  String get categoryCulture;

  /// No description provided for @categoryEcologie.
  ///
  /// In fr, this message translates to:
  /// **'Écologie'**
  String get categoryEcologie;

  /// No description provided for @categoryVolontariat.
  ///
  /// In fr, this message translates to:
  /// **'Volontariat'**
  String get categoryVolontariat;

  /// No description provided for @labelFree.
  ///
  /// In fr, this message translates to:
  /// **'Gratuit'**
  String get labelFree;

  /// No description provided for @labelPaid.
  ///
  /// In fr, this message translates to:
  /// **'Payant'**
  String get labelPaid;

  /// No description provided for @screenTitleProfile.
  ///
  /// In fr, this message translates to:
  /// **'Mon profil'**
  String get screenTitleProfile;

  /// No description provided for @btnSave.
  ///
  /// In fr, this message translates to:
  /// **'Enregistrer les modifications'**
  String get btnSave;

  /// No description provided for @sectionDangerZone.
  ///
  /// In fr, this message translates to:
  /// **'Zone de danger'**
  String get sectionDangerZone;

  /// No description provided for @btnClearData.
  ///
  /// In fr, this message translates to:
  /// **'Effacer les données locales'**
  String get btnClearData;

  /// No description provided for @dialogClearTitle.
  ///
  /// In fr, this message translates to:
  /// **'Effacer les données ?'**
  String get dialogClearTitle;

  /// No description provided for @dialogClearContent.
  ///
  /// In fr, this message translates to:
  /// **'Votre ville et vos préférences seront supprimées. Vous serez redirigé vers l\'accueil de configuration.'**
  String get dialogClearContent;

  /// No description provided for @actionCancel.
  ///
  /// In fr, this message translates to:
  /// **'Annuler'**
  String get actionCancel;

  /// No description provided for @actionDelete.
  ///
  /// In fr, this message translates to:
  /// **'Effacer'**
  String get actionDelete;

  /// No description provided for @screenTitleMap.
  ///
  /// In fr, this message translates to:
  /// **'Centres ODEJ'**
  String get screenTitleMap;

  /// No description provided for @btnContact.
  ///
  /// In fr, this message translates to:
  /// **'Contacter'**
  String get btnContact;

  /// No description provided for @hintSearch.
  ///
  /// In fr, this message translates to:
  /// **'Rechercher un événement...'**
  String get hintSearch;

  /// No description provided for @noSearchResults.
  ///
  /// In fr, this message translates to:
  /// **'Aucun résultat pour cette recherche.'**
  String get noSearchResults;

  /// No description provided for @btnViewOnMap.
  ///
  /// In fr, this message translates to:
  /// **'Voir sur la carte'**
  String get btnViewOnMap;

  /// No description provided for @filterAllCities.
  ///
  /// In fr, this message translates to:
  /// **'Toutes les villes'**
  String get filterAllCities;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'fr', 'tzm'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'fr':
      return AppLocalizationsFr();
    case 'tzm':
      return AppLocalizationsTzm();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
