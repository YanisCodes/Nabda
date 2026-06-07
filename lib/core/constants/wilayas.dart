class Wilaya {
  const Wilaya({
    required this.code,
    required this.nameFr,
    required this.nameAr,
  });

  final int code;
  final String nameFr;
  final String nameAr;

  @override
  String toString() => nameFr;
}

const List<Wilaya> kWilayas = [
  Wilaya(code: 1, nameFr: 'Adrar', nameAr: 'أدرار'),
  Wilaya(code: 2, nameFr: 'Chlef', nameAr: 'الشلف'),
  Wilaya(code: 3, nameFr: 'Laghouat', nameAr: 'الأغواط'),
  Wilaya(code: 4, nameFr: 'Oum El Bouaghi', nameAr: 'أم البواقي'),
  Wilaya(code: 5, nameFr: 'Batna', nameAr: 'باتنة'),
  Wilaya(code: 6, nameFr: 'Béjaïa', nameAr: 'بجاية'),
  Wilaya(code: 7, nameFr: 'Biskra', nameAr: 'بسكرة'),
  Wilaya(code: 8, nameFr: 'Béchar', nameAr: 'بشار'),
  Wilaya(code: 9, nameFr: 'Blida', nameAr: 'البليدة'),
  Wilaya(code: 10, nameFr: 'Bouira', nameAr: 'البويرة'),
  Wilaya(code: 11, nameFr: 'Tamanrasset', nameAr: 'تمنراست'),
  Wilaya(code: 12, nameFr: 'Tébessa', nameAr: 'تبسة'),
  Wilaya(code: 13, nameFr: 'Tlemcen', nameAr: 'تلمسان'),
  Wilaya(code: 14, nameFr: 'Tiaret', nameAr: 'تيارت'),
  Wilaya(code: 15, nameFr: 'Tizi Ouzou', nameAr: 'تيزي وزو'),
  Wilaya(code: 16, nameFr: 'Alger', nameAr: 'الجزائر'),
  Wilaya(code: 17, nameFr: 'Djelfa', nameAr: 'الجلفة'),
  Wilaya(code: 18, nameFr: 'Jijel', nameAr: 'جيجل'),
  Wilaya(code: 19, nameFr: 'Sétif', nameAr: 'سطيف'),
  Wilaya(code: 20, nameFr: 'Saïda', nameAr: 'سعيدة'),
  Wilaya(code: 21, nameFr: 'Skikda', nameAr: 'سكيكدة'),
  Wilaya(code: 22, nameFr: 'Sidi Bel Abbès', nameAr: 'سيدي بلعباس'),
  Wilaya(code: 23, nameFr: 'Annaba', nameAr: 'عنابة'),
  Wilaya(code: 24, nameFr: 'Guelma', nameAr: 'قالمة'),
  Wilaya(code: 25, nameFr: 'Constantine', nameAr: 'قسنطينة'),
  Wilaya(code: 26, nameFr: 'Médéa', nameAr: 'المدية'),
  Wilaya(code: 27, nameFr: 'Mostaganem', nameAr: 'مستغانم'),
  Wilaya(code: 28, nameFr: "M'Sila", nameAr: 'المسيلة'),
  Wilaya(code: 29, nameFr: 'Mascara', nameAr: 'معسكر'),
  Wilaya(code: 30, nameFr: 'Ouargla', nameAr: 'ورقلة'),
  Wilaya(code: 31, nameFr: 'Oran', nameAr: 'وهران'),
  Wilaya(code: 32, nameFr: 'El Bayadh', nameAr: 'البيض'),
  Wilaya(code: 33, nameFr: 'Illizi', nameAr: 'إليزي'),
  Wilaya(code: 34, nameFr: 'Bordj Bou Arréridj', nameAr: 'برج بوعريريج'),
  Wilaya(code: 35, nameFr: 'Boumerdès', nameAr: 'بومرداس'),
  Wilaya(code: 36, nameFr: 'El Tarf', nameAr: 'الطارف'),
  Wilaya(code: 37, nameFr: 'Tindouf', nameAr: 'تندوف'),
  Wilaya(code: 38, nameFr: 'Tissemsilt', nameAr: 'تيسمسيلت'),
  Wilaya(code: 39, nameFr: 'El Oued', nameAr: 'الوادي'),
  Wilaya(code: 40, nameFr: 'Khenchela', nameAr: 'خنشلة'),
  Wilaya(code: 41, nameFr: 'Souk Ahras', nameAr: 'سوق أهراس'),
  Wilaya(code: 42, nameFr: 'Tipaza', nameAr: 'تيبازة'),
  Wilaya(code: 43, nameFr: 'Mila', nameAr: 'ميلة'),
  Wilaya(code: 44, nameFr: 'Aïn Defla', nameAr: 'عين الدفلى'),
  Wilaya(code: 45, nameFr: 'Naâma', nameAr: 'النعامة'),
  Wilaya(code: 46, nameFr: 'Aïn Témouchent', nameAr: 'عين تموشنت'),
  Wilaya(code: 47, nameFr: 'Ghardaïa', nameAr: 'غرداية'),
  Wilaya(code: 48, nameFr: 'Relizane', nameAr: 'غليزان'),
  Wilaya(code: 49, nameFr: 'Timimoun', nameAr: 'تيميمون'),
  Wilaya(code: 50, nameFr: 'Bordj Badji Mokhtar', nameAr: 'برج باجي مختار'),
  Wilaya(code: 51, nameFr: 'Ouled Djellal', nameAr: 'أولاد جلال'),
  Wilaya(code: 52, nameFr: 'Béni Abbès', nameAr: 'بني عباس'),
  Wilaya(code: 53, nameFr: 'In Salah', nameAr: 'عين صالح'),
  Wilaya(code: 54, nameFr: 'In Guezzam', nameAr: 'عين قزام'),
  Wilaya(code: 55, nameFr: 'Touggourt', nameAr: 'تقرت'),
  Wilaya(code: 56, nameFr: 'Djanet', nameAr: 'جانت'),
  Wilaya(code: 57, nameFr: "El M'Ghair", nameAr: 'المغير'),
  Wilaya(code: 58, nameFr: 'El Meniaa', nameAr: 'المنيعة'),
];

Wilaya? wilayaByName(String nameFr) {
  try {
    return kWilayas.firstWhere(
      (w) => w.nameFr.toLowerCase() == nameFr.toLowerCase(),
    );
  } catch (_) {
    return null;
  }
}
