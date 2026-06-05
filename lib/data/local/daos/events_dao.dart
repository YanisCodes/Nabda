import 'package:drift/drift.dart';

import '../../../data/models/event.dart';
import '../../../data/models/event_category.dart';
import '../database.dart';

part 'events_dao.g.dart';

@DriftAccessor(tables: [Events])
class EventsDao extends DatabaseAccessor<AppDatabase> with _$EventsDaoMixin {
  EventsDao(super.db);

  Future<List<Event>> getAllModels() async {
    final rows = await (select(events)
          ..orderBy([(t) => OrderingTerm.asc(t.dateStart)]))
        .get();
    return rows.map((r) => r.toModel()).toList();
  }

  Future<List<Event>> getByCityModels(String city) async {
    final all = await getAllModels();
    return all
        .where((e) => e.city.toLowerCase() == city.toLowerCase())
        .toList();
  }

  Future<List<Event>> getByCategoryModels(EventCategory category) async {
    final rows = await (select(events)
          ..where((t) => t.category.equals(category.name))
          ..orderBy([(t) => OrderingTerm.asc(t.dateStart)]))
        .get();
    return rows.map((r) => r.toModel()).toList();
  }

  Future<void> upsertAll(List<EventsCompanion> rows) async {
    await batch((b) => b.insertAllOnConflictUpdate(events, rows));
  }
}
