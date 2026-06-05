import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/local/data_providers.dart';
import '../../data/local/preferences.dart';
import '../../data/models/center.dart' as model;
import '../../data/models/event.dart';

class HomeState {
  const HomeState({
    required this.city,
    required this.upcomingEvents,
    required this.centers,
    required this.cityHasEvents,
  });

  final String city;
  final List<Event> upcomingEvents;
  final List<model.Center> centers;

  /// false quand aucun événement pour la ville → fallback sur tout
  final bool cityHasEvents;
}

class HomeNotifier extends Notifier<HomeState> {
  @override
  HomeState build() {
    final allEvents = ref.watch(eventsListProvider);
    final allCenters = ref.watch(centersListProvider);
    final prefs = ref.read(preferencesProvider);
    final city = prefs.city ?? '';

    final cityEvents = allEvents
        .where((e) => e.city.toLowerCase() == city.toLowerCase())
        .toList();
    final cityHasEvents = cityEvents.isNotEmpty;

    final upcomingEvents =
        (cityHasEvents ? cityEvents : allEvents).take(5).toList();

    final citycenters = allCenters
        .where((c) => c.city.toLowerCase() == city.toLowerCase())
        .toList();
    final nearbyCenters =
        (citycenters.isNotEmpty ? citycenters : allCenters).take(3).toList();

    return HomeState(
      city: city,
      upcomingEvents: upcomingEvents,
      centers: nearbyCenters,
      cityHasEvents: cityHasEvents,
    );
  }
}

final homeProvider =
    NotifierProvider<HomeNotifier, HomeState>(HomeNotifier.new);
