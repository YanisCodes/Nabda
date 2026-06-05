import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/local/mock_repository.dart';
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

  /// false quand il n'y avait pas d'événements pour la ville → fallback sur tout
  final bool cityHasEvents;
}

class HomeNotifier extends Notifier<HomeState> {
  @override
  HomeState build() {
    final prefs = ref.read(preferencesProvider);
    final city = prefs.city ?? '';

    var events = MockRepository.getEvents(city: city);
    final cityHasEvents = events.isNotEmpty;

    if (!cityHasEvents) {
      events = MockRepository.getEvents();
    }
    final upcomingEvents = events.take(5).toList();

    var centers = MockRepository.getCenters(city: city);
    if (centers.isEmpty) {
      centers = MockRepository.getCenters();
    }
    final nearbyCenters = centers.take(3).toList();

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
