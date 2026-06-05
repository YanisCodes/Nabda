import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/local/mock_repository.dart';
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
  ExploreState build() => ExploreState(
        selectedCategory: null,
        events: MockRepository.getEvents(),
      );

  void selectCategory(EventCategory? category) {
    state = ExploreState(
      selectedCategory: category,
      events: MockRepository.getEvents(category: category),
    );
  }
}

final exploreProvider =
    NotifierProvider<ExploreNotifier, ExploreState>(ExploreNotifier.new);
