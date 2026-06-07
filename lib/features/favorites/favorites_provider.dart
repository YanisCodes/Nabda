import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/local/preferences.dart';

final favoritesProvider = NotifierProvider<FavoritesNotifier, Set<String>>(
  FavoritesNotifier.new,
);

class FavoritesNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() {
    return ref.read(preferencesProvider).favoriteIds;
  }

  void toggleFavorite(String eventId) {
    final updated = Set<String>.from(state);
    if (updated.contains(eventId)) {
      updated.remove(eventId);
    } else {
      updated.add(eventId);
    }
    ref.read(preferencesProvider).setFavoriteIds(updated);
    state = updated;
  }

  void clear() {
    ref.read(preferencesProvider).setFavoriteIds({});
    state = {};
  }
}
