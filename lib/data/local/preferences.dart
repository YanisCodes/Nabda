import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_language.dart';

class Preferences {
  Preferences(this._prefs);

  final SharedPreferences _prefs;

  static const _kCity = 'user_city';
  static const _kLang = 'user_lang';

  String? get city => _prefs.getString(_kCity);
  AppLanguage get language =>
      AppLanguage.fromCode(_prefs.getString(_kLang) ?? 'fr');
  bool get isFirstLaunch => city == null;

  Future<void> setCity(String city) => _prefs.setString(_kCity, city);
  Future<void> setLanguage(AppLanguage lang) =>
      _prefs.setString(_kLang, lang.code);
  Future<void> clearAll() => _prefs.clear();
}

// Surchargé dans main() via ProviderScope.overrides
final preferencesProvider = Provider<Preferences>(
  (_) => throw UnimplementedError('preferencesProvider must be overridden'),
);
