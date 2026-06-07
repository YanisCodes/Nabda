import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/app_language.dart';
import '../models/center.dart' as model;
import '../models/event.dart';
import '../models/event_category.dart';
import '../../core/constants/mock_data.dart';
import 'daos/centers_dao.dart';
import 'daos/events_dao.dart';

part 'database.g.dart';

// ─── Tables ───────────────────────────────────────────────────────────────────

// @DataClassName évite le conflit avec nos modèles Event / Center
@DataClassName('EventRow')
class Events extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get city => text()();
  TextColumn get category => text()();
  DateTimeColumn get dateStart => dateTime()();
  DateTimeColumn get dateEnd => dateTime().nullable()();
  TextColumn get centerId => text().nullable()();
  BoolColumn get isFree => boolean()();
  TextColumn get imageUrl => text().nullable()();
  TextColumn get lang => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('CenterRow')
class Centers extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get city => text()();
  TextColumn get address => text()();
  RealColumn get lat => real()();
  RealColumn get lng => real()();
  TextColumn get phone => text()();
  TextColumn get hours => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('SyncMetaRow')
class SyncMeta extends Table {
  TextColumn get entity => text()(); // 'events' | 'centers'
  DateTimeColumn get lastSync => dateTime()();

  @override
  Set<Column> get primaryKey => {entity};
}

// ─── Base de données ──────────────────────────────────────────────────────────

@DriftDatabase(tables: [Events, Centers, SyncMeta])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'otej_link'));

  @override
  int get schemaVersion => 1;

  EventsDao get eventsDao => EventsDao(this);
  CentersDao get centersDao => CentersDao(this);

  /// Insert les données mockées si la base est vide (premier lancement).
  Future<void> seedIfEmpty() async {
    final existing = await (select(events)..limit(1)).get();
    if (existing.isNotEmpty) return;

    await batch((b) {
      b.insertAll(
        events,
        kMockEvents.map(
          (e) => EventsCompanion(
            id: Value(e.id),
            title: Value(e.title),
            description: Value(e.description),
            city: Value(e.city),
            category: Value(e.category.name),
            dateStart: Value(e.dateStart),
            dateEnd: Value(e.dateEnd),
            centerId: Value(e.centerId),
            isFree: Value(e.isFree),
            imageUrl: Value(e.imageUrl),
            lang: Value(e.lang.code),
            createdAt: Value(e.createdAt),
          ),
        ),
      );

      b.insertAll(
        centers,
        kMockCenters.map(
          (c) => CentersCompanion(
            id: Value(c.id),
            name: Value(c.name),
            city: Value(c.city),
            address: Value(c.address),
            lat: Value(c.lat),
            lng: Value(c.lng),
            phone: Value(c.phone),
            hours: Value(c.hours),
            createdAt: Value(c.createdAt),
          ),
        ),
      );
    });
  }
}

// ─── Conversions row → model ──────────────────────────────────────────────────

extension EventRowX on EventRow {
  Event toModel() => Event(
    id: id,
    title: title,
    description: description,
    city: city,
    category: EventCategory.fromString(category),
    dateStart: dateStart,
    dateEnd: dateEnd,
    centerId: centerId,
    isFree: isFree,
    imageUrl: imageUrl,
    lang: AppLanguage.fromCode(lang),
    createdAt: createdAt,
  );
}

extension CenterRowX on CenterRow {
  model.Center toModel() => model.Center(
    id: id,
    name: name,
    city: city,
    address: address,
    lat: lat,
    lng: lng,
    phone: phone,
    hours: hours,
    createdAt: createdAt,
  );
}

// ─── Provider ─────────────────────────────────────────────────────────────────

final databaseProvider = Provider<AppDatabase>(
  (_) =>
      throw UnimplementedError('databaseProvider must be overridden in main'),
);
