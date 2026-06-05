import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/local/data_providers.dart';
import '../../data/models/event.dart';
import '../../data/models/event_category.dart';

class ExploreState {
  const ExploreState({
    this.selectedCategory,
    required this.events,
  });

  final EventCategory? selectedCategory;
  final List<Event> events;
}

class ExploreNotifier extends Notifier<ExploreState> {
  @override
  ExploreState build() {
    final allEvents = ref.watch(eventsListProvider);
    return ExploreState(selectedCategory: null, events: allEvents);
  }

  void selectCategory(EventCategory? category) {
    final allEvents = ref.read(eventsListProvider);
    final filtered = category == null
        ? allEvents
        : allEvents.where((e) => e.category == category).toList();
    state = ExploreState(selectedCategory: category, events: filtered);
  }
}

final exploreProvider =
    NotifierProvider<ExploreNotifier, ExploreState>(ExploreNotifier.new);
