enum AppLanguage {
  fr,
  ar,
  tz;

  String get code => name;

  static AppLanguage fromCode(String code) {
    return AppLanguage.values.firstWhere(
      (l) => l.code == code,
      orElse: () => AppLanguage.fr,
    );
  }
}
