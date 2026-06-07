import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/local/data_providers.dart';
import '../../data/local/preferences.dart';
import '../../data/models/center.dart' as model;
import '../../data/models/event.dart';
import '../../data/models/event_category.dart';

class HomeState {
  const HomeState({
    required this.city,
    required this.upcomingEvents,
    required this.centers,
    required this.cityHasEvents,
    required this.isPersonalized,
  });

  final String city;
  final List<Event> upcomingEvents;
  final List<model.Center> centers;

  /// false quand aucun événement pour la ville → fallback sur tout
  final bool cityHasEvents;

  /// true quand l'utilisateur a défini au moins un centre d'intérêt
  final bool isPersonalized;
}

class HomeNotifier extends Notifier<HomeState> {
  @override
  HomeState build() {
    final allEvents = ref.watch(eventsListProvider);
    final allCenters = ref.watch(centersListProvider);
    final prefs = ref.read(preferencesProvider);
    final city = prefs.city ?? '';
    final interests = prefs.interests;

    final cityEvents = allEvents
        .where((e) => e.city.toLowerCase() == city.toLowerCase())
        .toList();
    final cityHasEvents = cityEvents.isNotEmpty;

    final pool = cityHasEvents ? cityEvents : allEvents;
    final upcomingEvents = _sortByInterests(pool, interests).take(5).toList();

    final citycenters = allCenters
        .where((c) => c.city.toLowerCase() == city.toLowerCase())
        .toList();
    final nearbyCenters = (citycenters.isNotEmpty ? citycenters : allCenters)
        .take(3)
        .toList();

    return HomeState(
      city: city,
      upcomingEvents: upcomingEvents,
      centers: nearbyCenters,
      cityHasEvents: cityHasEvents,
      isPersonalized: interests.isNotEmpty,
    );
  }

  /// Événements dont la catégorie est dans les intérêts en premier,
  /// puis le reste. Ordre chronologique dans chaque groupe.
  List<Event> _sortByInterests(
    List<Event> events,
    Set<EventCategory> interests,
  ) {
    if (interests.isEmpty) {
      return events..sort((a, b) => a.dateStart.compareTo(b.dateStart));
    }
    final matched = events.where((e) => interests.contains(e.category)).toList()
      ..sort((a, b) => a.dateStart.compareTo(b.dateStart));
    final others = events.where((e) => !interests.contains(e.category)).toList()
      ..sort((a, b) => a.dateStart.compareTo(b.dateStart));
    return [...matched, ...others];
  }
}

final homeProvider = NotifierProvider<HomeNotifier, HomeState>(
  HomeNotifier.new,
);
