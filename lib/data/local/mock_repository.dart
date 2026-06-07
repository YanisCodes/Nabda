import '../../core/constants/mock_data.dart';
import '../models/category.dart';
import '../models/center.dart';
import '../models/event.dart';
import '../models/event_category.dart';

// Accès simple aux données statiques. Sera remplacé par drift (T29-T32).
class MockRepository {
  const MockRepository._();

  static List<Event> getEvents({EventCategory? category, String? city}) {
    var events = List<Event>.from(kMockEvents);

    if (category != null) {
      events = events.where((e) => e.category == category).toList();
    }
    if (city != null && city.isNotEmpty) {
      events = events
          .where((e) => e.city.toLowerCase() == city.toLowerCase())
          .toList();
    }

    events.sort((a, b) => a.dateStart.compareTo(b.dateStart));
    return events;
  }

  static List<Center> getCenters({String? city}) {
    if (city == null || city.isEmpty) return List.unmodifiable(kMockCenters);
    return kMockCenters
        .where((c) => c.city.toLowerCase() == city.toLowerCase())
        .toList();
  }

  static Center? getCenterById(String id) {
    try {
      return kMockCenters.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  static List<Category> getCategories() => List.unmodifiable(kCategories);
}
