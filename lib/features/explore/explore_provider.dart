import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/local/data_providers.dart';
import '../../data/models/event.dart';
import '../../data/models/event_category.dart';

class ExploreState {
  const ExploreState({
    this.selectedCategory,
    this.selectedCity,
    this.searchQuery = '',
    required this.availableCities,
    required this.events,
  });

  final EventCategory? selectedCategory;
  final String? selectedCity;
  final String searchQuery;
  final List<String> availableCities;
  final List<Event> events;
}

class ExploreNotifier extends Notifier<ExploreState> {
  @override
  ExploreState build() {
    final allEvents = ref.watch(eventsListProvider);
    final cities = _extractCities(allEvents);
    return ExploreState(
      selectedCategory: null,
      selectedCity: null,
      searchQuery: '',
      availableCities: cities,
      events: _filter(allEvents, null, null, ''),
    );
  }

  List<String> _extractCities(List<Event> events) =>
      (events.map((e) => e.city).toSet().toList()..sort());

  List<Event> _filter(
    List<Event> all,
    EventCategory? cat,
    String? city,
    String query,
  ) {
    var result = all;
    if (cat != null) {
      result = result.where((e) => e.category == cat).toList();
    }
    if (city != null) {
      result = result.where((e) => e.city == city).toList();
    }
    final q = query.trim().toLowerCase();
    if (q.isNotEmpty) {
      result = result
          .where(
            (e) =>
                e.title.toLowerCase().contains(q) ||
                e.city.toLowerCase().contains(q) ||
                e.description.toLowerCase().contains(q),
          )
          .toList();
    }
    result.sort((a, b) => a.dateStart.compareTo(b.dateStart));
    return result;
  }

  void selectCategory(EventCategory? category) {
    final all = ref.read(eventsListProvider);
    state = ExploreState(
      selectedCategory: category,
      selectedCity: state.selectedCity,
      searchQuery: state.searchQuery,
      availableCities: state.availableCities,
      events: _filter(all, category, state.selectedCity, state.searchQuery),
    );
  }

  void selectCity(String? city) {
    final all = ref.read(eventsListProvider);
    state = ExploreState(
      selectedCategory: state.selectedCategory,
      selectedCity: city,
      searchQuery: state.searchQuery,
      availableCities: state.availableCities,
      events: _filter(all, state.selectedCategory, city, state.searchQuery),
    );
  }

  void setSearch(String query) {
    final all = ref.read(eventsListProvider);
    state = ExploreState(
      selectedCategory: state.selectedCategory,
      selectedCity: state.selectedCity,
      searchQuery: query,
      availableCities: state.availableCities,
      events: _filter(all, state.selectedCategory, state.selectedCity, query),
    );
  }
}

final exploreProvider =
    NotifierProvider<ExploreNotifier, ExploreState>(ExploreNotifier.new);
