import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_language.dart';
import '../models/event_category.dart';

class Preferences {
  Preferences(this._prefs);

  final SharedPreferences _prefs;

  static const _kCity = 'user_city';
  static const _kLang = 'user_lang';
  static const _kInterests = 'user_interests';
  static const _kFavorites = 'favorite_ids';
  static const _kReminders = 'reminder_ids';

  String? get city => _prefs.getString(_kCity);
  AppLanguage get language =>
      AppLanguage.fromCode(_prefs.getString(_kLang) ?? 'fr');
  bool get isFirstLaunch => city == null;

  Set<EventCategory> get interests {
    final raw = _prefs.getString(_kInterests);
    if (raw == null) return {};
    final list = (jsonDecode(raw) as List).cast<String>();
    return list.map(EventCategory.fromString).toSet();
  }

  Set<String> get favoriteIds {
    final raw = _prefs.getStringList(_kFavorites);
    return raw?.toSet() ?? {};
  }

  Future<void> setCity(String city) => _prefs.setString(_kCity, city);
  Future<void> setLanguage(AppLanguage lang) =>
      _prefs.setString(_kLang, lang.code);
  Future<void> setInterests(Set<EventCategory> interests) => _prefs.setString(
    _kInterests,
    jsonEncode(interests.map((e) => e.name).toList()),
  );
  Future<void> setFavoriteIds(Set<String> ids) =>
      _prefs.setStringList(_kFavorites, ids.toList());

  Set<String> get reminderIds {
    final raw = _prefs.getStringList(_kReminders);
    return raw?.toSet() ?? {};
  }

  Future<void> setReminderIds(Set<String> ids) =>
      _prefs.setStringList(_kReminders, ids.toList());

  Future<void> clearAll() => _prefs.clear();
}

// Surchargé dans main() via ProviderScope.overrides
final preferencesProvider = Provider<Preferences>(
  (_) => throw UnimplementedError('preferencesProvider must be overridden'),
);
