import 'event_category.dart';

class Category {
  const Category({
    required this.id,
    required this.nameFr,
    required this.nameAr,
    required this.nameTz,
    required this.icon,
  });

  final EventCategory id;
  final String nameFr;
  final String nameAr;
  final String nameTz;
  final String icon;

  String localizedName(String langCode) => switch (langCode) {
        'ar' => nameAr,
        'tz' => nameTz,
        _ => nameFr,
      };
}
