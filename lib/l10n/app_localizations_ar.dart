// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'OTEJ Link';

  @override
  String get onboardingSubtitle => 'خصّص تجربتك\nاكتشف الفرص القريبة منك.';

  @override
  String get labelYourCity => 'مدينتك';

  @override
  String get hintSelectWilaya => 'اختر ولاية';

  @override
  String get labelYourLanguage => 'لغتك';

  @override
  String get btnStart => 'ابدأ';

  @override
  String greetingWithCity(String city) {
    return 'مرحباً، $city!';
  }

  @override
  String get greetingNoCity => 'مرحباً!';

  @override
  String get homeSubtitle => 'اكتشف فرص ODEJ القريبة منك.';

  @override
  String homeSubtitleFallback(String city) {
    return 'لا توجد أحداث في $city بعد.\nإليك الأحداث القادمة المتاحة.';
  }

  @override
  String get sectionThisWeek => 'هذا الأسبوع';

  @override
  String get sectionNearbyCenters => 'مراكز قريبة';

  @override
  String get actionSeeAll => 'عرض الكل';

  @override
  String get noEventsAvailable => 'لا توجد أحداث متاحة حالياً.';

  @override
  String get btnExploreAll => 'استكشف الكل';

  @override
  String get noCentersFound => 'لم يُعثر على مراكز.';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navExplore => 'استكشاف';

  @override
  String get navMap => 'خريطة';

  @override
  String get screenTitleExplore => 'استكشاف';

  @override
  String get chipAll => 'الكل';

  @override
  String get noEventsInCategory => 'لا توجد أحداث في هذه الفئة';

  @override
  String get sectionAbout => 'حول';

  @override
  String get sectionOrganizerCenter => 'المركز المنظّم';

  @override
  String get btnContactCenter => 'الاتصال بالمركز';

  @override
  String get errorCantOpenPhone => 'تعذّر فتح تطبيق الهاتف';

  @override
  String get categoryFormation => 'تكوين';

  @override
  String get categorySport => 'رياضة';

  @override
  String get categoryCulture => 'ثقافة';

  @override
  String get categoryEcologie => 'بيئة';

  @override
  String get categoryVolontariat => 'تطوع';

  @override
  String get labelFree => 'مجاني';

  @override
  String get labelPaid => 'مدفوع';

  @override
  String get screenTitleProfile => 'ملفي الشخصي';

  @override
  String get btnSave => 'حفظ التعديلات';

  @override
  String get sectionDangerZone => 'منطقة الخطر';

  @override
  String get btnClearData => 'مسح البيانات المحلية';

  @override
  String get dialogClearTitle => 'مسح البيانات؟';

  @override
  String get dialogClearContent =>
      'سيتم حذف مدينتك وتفضيلاتك. ستعود إلى شاشة الإعداد.';

  @override
  String get actionCancel => 'إلغاء';

  @override
  String get actionDelete => 'مسح';

  @override
  String get screenTitleMap => 'مراكز ODEJ';

  @override
  String get btnContact => 'اتصل';

  @override
  String get hintSearch => 'ابحث عن حدث...';

  @override
  String get noSearchResults => 'لا توجد نتائج لهذا البحث.';

  @override
  String get btnViewOnMap => 'عرض على الخريطة';

  @override
  String get filterAllCities => 'كل الولايات';

  @override
  String get sectionInterests => 'مراكز الاهتمام';

  @override
  String get sectionForYou => 'لك أنت';

  @override
  String get labelSoon => 'قريباً';

  @override
  String get labelOngoing => 'جارٍ الآن';
}
