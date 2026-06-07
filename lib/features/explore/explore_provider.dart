import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/local/data_providers.dart';
import '../../data/models/event.dart';
import '../../data/models/event_category.dart';

enum DatePreset { all, today, thisWeek, thisMonth }

class ExploreState {
  const ExploreState({
    this.selectedCategory,
    this.selectedCity,
    this.searchQuery = '',
    this.datePreset = DatePreset.all,
    required this.availableCities,
    required this.events,
  });

  final EventCategory? selectedCategory;
  final String? selectedCity;
  final String searchQuery;
  final DatePreset datePreset;
  final List<String> availableCities;
  final List<Event> events;
}

class ExploreNotifier extends Notifier<ExploreState> {
  @override
  ExploreState build() {
    final allEvents = ref.watch(eventsListProvider);
    final cities = _extractCities(allEvents);
    return ExploreState(
      availableCities: cities,
      events: _filter(allEvents, null, null, '', DatePreset.all),
    );
  }

  List<String> _extractCities(List<Event> events) =>
      (events.map((e) => e.city).toSet().toList()..sort());

  List<Event> _filter(
    List<Event> all,
    EventCategory? cat,
    String? city,
    String query,
    DatePreset datePreset,
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
    if (datePreset != DatePreset.all) {
      final range = _dateRange(datePreset);
      if (range != null) {
        result = result.where((e) => _eventInRange(e, range)).toList();
      }
    }
    result.sort((a, b) => a.dateStart.compareTo(b.dateStart));
    return result;
  }

  ExploreState _rebuild({
    EventCategory? Function()? category,
    String? Function()? city,
    String? query,
    DatePreset? datePreset,
  }) {
    final all = ref.read(eventsListProvider);
    final cat = category != null ? category() : state.selectedCategory;
    final c = city != null ? city() : state.selectedCity;
    final q = query ?? state.searchQuery;
    final dp = datePreset ?? state.datePreset;
    return ExploreState(
      selectedCategory: cat,
      selectedCity: c,
      searchQuery: q,
      datePreset: dp,
      availableCities: state.availableCities,
      events: _filter(all, cat, c, q, dp),
    );
  }

  void selectCategory(EventCategory? category) {
    state = _rebuild(category: () => category);
  }

  void selectCity(String? city) {
    state = _rebuild(city: () => city);
  }

  void setSearch(String query) {
    state = _rebuild(query: query);
  }

  void selectDatePreset(DatePreset preset) {
    state = _rebuild(datePreset: preset);
  }
}

({DateTime start, DateTime end})? _dateRange(DatePreset preset) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  return switch (preset) {
    DatePreset.all => null,
    DatePreset.today => (start: today, end: today.add(const Duration(days: 1))),
    DatePreset.thisWeek => (
      start: today.subtract(Duration(days: today.weekday - 1)),
      end: today
          .subtract(Duration(days: today.weekday - 1))
          .add(const Duration(days: 7)),
    ),
    DatePreset.thisMonth => (
      start: DateTime(now.year, now.month),
      end: DateTime(now.year, now.month + 1),
    ),
  };
}

bool _eventInRange(Event e, ({DateTime start, DateTime end}) range) {
  final effectiveEnd = e.dateEnd ?? e.dateStart;
  return e.dateStart.isBefore(range.end) && !effectiveEnd.isBefore(range.start);
}

final exploreProvider = NotifierProvider<ExploreNotifier, ExploreState>(
  ExploreNotifier.new,
);
