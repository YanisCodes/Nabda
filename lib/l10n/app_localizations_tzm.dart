// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Central Atlas Tamazight (`tzm`).
class AppLocalizationsTzm extends AppLocalizations {
  AppLocalizationsTzm([String locale = 'tzm']) : super(locale);

  @override
  String get appName => 'OTEJ Link';

  @override
  String get onboardingSubtitle =>
      'Sentel taḥricett·ik\naff tifursiwin ifadden·ik.';

  @override
  String get labelYourCity => 'Tamendawt·nnek';

  @override
  String get hintSelectWilaya => 'Fren tawilat';

  @override
  String get labelYourLanguage => 'Tutlayt·nnek';

  @override
  String get btnStart => 'Bdu';

  @override
  String greetingWithCity(String city) {
    return 'Ansuf, $city!';
  }

  @override
  String get greetingNoCity => 'Ansuf!';

  @override
  String get homeSubtitle => 'Aff tifursiwin n ODEJ deg temnaḍt·nnek.';

  @override
  String homeSubtitleFallback(String city) {
    return 'Ulac imunas deg $city.\nNer wiyeḍ ara yas.';
  }

  @override
  String get sectionThisWeek => 'Yiwen wass-a';

  @override
  String get sectionNearbyCenters => 'Imaẓayen ifadden';

  @override
  String get actionSeeAll => 'Wali meṛṛa';

  @override
  String get noEventsAvailable => 'Ulac imunas akka tura.';

  @override
  String get btnExploreAll => 'Nadi meṛṛa';

  @override
  String get noCentersFound => 'Ulac imaẓayen.';

  @override
  String get navHome => 'Axxam';

  @override
  String get navExplore => 'Nadi';

  @override
  String get navMap => 'Tasedwit';

  @override
  String get screenTitleExplore => 'Nadi';

  @override
  String get chipAll => 'Meṛṛa';

  @override
  String get noEventsInCategory => 'Ulac imunas deg usmel-a';

  @override
  String get sectionAbout => 'Fell-as';

  @override
  String get sectionOrganizerCenter => 'Amazray amẓiwen';

  @override
  String get btnContactCenter => 'Muqel amazray';

  @override
  String get errorCantOpenPhone => 'Ur zemreɣ ara ad ldiɣ aselkim';

  @override
  String get categoryFormation => 'Tazrawt';

  @override
  String get categorySport => 'Azilal';

  @override
  String get categoryCulture => 'Tussna';

  @override
  String get categoryEcologie => 'Tilawt';

  @override
  String get categoryVolontariat => 'Tanelmadt';

  @override
  String get labelFree => 'Ibeṛṛa';

  @override
  String get labelPaid => 'Yettuzeyyad';

  @override
  String get screenTitleProfile => 'Iprofil·iw';

  @override
  String get btnSave => 'Sekles';

  @override
  String get sectionDangerZone => 'Atig n lxeṭṛ';

  @override
  String get btnClearData => 'Kkes isefka';

  @override
  String get dialogClearTitle => 'Kkes isefka?';

  @override
  String get dialogClearContent =>
      'Tamendawt·nnek d lmexyal·nnek ad ttwaḥkument. Ad tɣiḍ ɣer usebded.';

  @override
  String get actionCancel => 'Sefsex';

  @override
  String get actionDelete => 'Kkes';

  @override
  String get screenTitleMap => 'Imaẓayen n ODEJ';

  @override
  String get btnContact => 'Muqel';

  @override
  String get hintSearch => 'Nadi amunas...';

  @override
  String get noSearchResults => 'Ulac anaẓur i unadi·a.';

  @override
  String get btnViewOnMap => 'Wali deg tasedwit';

  @override
  String get filterAllCities => 'Meṛṛa timendawin';

  @override
  String get sectionInterests => 'Iswi·nnek';

  @override
  String get sectionForYou => 'I kem/kek';

  @override
  String get labelSoon => 'Seld';

  @override
  String get labelOngoing => 'Tura';

  @override
  String get navSaved => 'Iḥerraz';

  @override
  String get noSavedEvents => 'Ulac imunas yettwaḥerzen.';

  @override
  String get btnAddToCalendar => 'Rnu ɣer wawalen';

  @override
  String get filterAllDates => 'Meṛṛa';

  @override
  String get filterToday => 'Ass-a';

  @override
  String get filterThisWeek => 'Dduṛt-a';

  @override
  String get filterThisMonth => 'Aggur-a';

  @override
  String get btnReportProblem => 'Ini-d ugur';

  @override
  String get btnReportEvent => 'Ini-d ugur ɣef umunas-a';

  @override
  String get errorCantOpenEmail => 'Ur zemreɣ ara ad ldiɣ email';

  @override
  String get btnSetReminder => 'Smekti-yi-d';

  @override
  String get btnReminderSet => 'Asmekti yella';

  @override
  String get snackReminderSet => 'Asmekti yettwarmed 1h send amunas';

  @override
  String get snackReminderRemoved => 'Asmekti yettwakkes';

  @override
  String get snackReminderTooLate => 'Amunas d aqrib aṭas i usmekti';
}
