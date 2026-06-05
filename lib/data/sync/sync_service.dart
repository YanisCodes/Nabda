import 'package:drift/drift.dart' show Value;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/constants/env.dart';
import '../local/data_providers.dart';
import '../local/database.dart';

/// Durée minimale entre deux syncs automatiques.
const _kSyncInterval = Duration(hours: 24);

class SyncService extends Notifier<bool> {
  @override
  bool build() => false; // isSyncing

  /// Vérifie SyncMeta — sync seulement si données > 24h ou jamais synchronisées.
  Future<void> syncIfStale() async {
    if (!Env.isConfigured) return;
    final db = ref.read(databaseProvider);

    final staleEvents = await _isStale(db, 'events');
    final staleCenters = await _isStale(db, 'centers');
    if (!staleEvents && !staleCenters) return;

    state = true;
    try {
      final client = Supabase.instance.client;
      if (staleEvents) await _syncEvents(db, client);
      if (staleCenters) await _syncCenters(db, client);
      await _refreshProviders(db);
    } catch (_) {
      // Échec silencieux — l'app fonctionne en mode offline
    } finally {
      state = false;
    }
  }

  /// Sync forcée — appelée par pull-to-refresh.
  Future<void> syncNow() async {
    if (!Env.isConfigured) return;
    state = true;
    try {
      final db = ref.read(databaseProvider);
      final client = Supabase.instance.client;
      await _syncEvents(db, client);
      await _syncCenters(db, client);
      await _refreshProviders(db);
    } catch (_) {
      // Échec silencieux
    } finally {
      state = false;
    }
  }

  // ─── Sync events ────────────────────────────────────────────────────────────

  Future<void> _syncEvents(AppDatabase db, SupabaseClient client) async {
    final lastSync = await _lastSync(db, 'events');
    final query = client.from('events').select();
    final rows = lastSync != null
        ? await query.gt('created_at', lastSync.toIso8601String())
        : await query;

    if (rows.isEmpty) return;

    await db.eventsDao.upsertAll(
      rows.map(_rowToEventCompanion).toList(),
    );
    await _updateSyncMeta(db, 'events');
  }

  // ─── Sync centers ───────────────────────────────────────────────────────────

  Future<void> _syncCenters(AppDatabase db, SupabaseClient client) async {
    final lastSync = await _lastSync(db, 'centers');
    final query = client.from('centers').select();
    final rows = lastSync != null
        ? await query.gt('created_at', lastSync.toIso8601String())
        : await query;

    if (rows.isEmpty) return;

    await db.centersDao.upsertAll(
      rows.map(_rowToCenterCompanion).toList(),
    );
    await _updateSyncMeta(db, 'centers');
  }

  // ─── SyncMeta helpers ────────────────────────────────────────────────────────

  Future<bool> _isStale(AppDatabase db, String entity) async {
    final last = await _lastSync(db, entity);
    if (last == null) return true;
    return DateTime.now().difference(last) > _kSyncInterval;
  }

  Future<DateTime?> _lastSync(AppDatabase db, String entity) async {
    final row = await (db.select(db.syncMeta)
          ..where((t) => t.entity.equals(entity)))
        .getSingleOrNull();
    return row?.lastSync;
  }

  Future<void> _updateSyncMeta(AppDatabase db, String entity) async {
    await db.into(db.syncMeta).insertOnConflictUpdate(
      SyncMetaCompanion(
        entity: Value(entity),
        lastSync: Value(DateTime.now()),
      ),
    );
  }

  // ─── Refresh providers après sync ────────────────────────────────────────────

  Future<void> _refreshProviders(AppDatabase db) async {
    final events = await db.eventsDao.getAllModels();
    final centers = await db.centersDao.getAllModels();
    ref.read(eventsListProvider.notifier).state = events;
    ref.read(centersListProvider.notifier).state = centers;
  }

  // ─── Conversions Supabase → Companion ────────────────────────────────────────

  EventsCompanion _rowToEventCompanion(Map<String, dynamic> r) {
    return EventsCompanion(
      id: Value(r['id'] as String),
      title: Value(r['title'] as String),
      description: Value(r['description'] as String),
      city: Value(r['city'] as String),
      category: Value(r['category'] as String),
      dateStart: Value(DateTime.parse(r['date_start'] as String)),
      dateEnd: Value(
        r['date_end'] != null
            ? DateTime.parse(r['date_end'] as String)
            : null,
      ),
      centerId: Value(r['center_id'] as String?),
      isFree: Value(r['is_free'] as bool),
      imageUrl: Value(r['image_url'] as String?),
      lang: Value((r['lang'] as String?) ?? 'fr'),
      createdAt: Value(DateTime.parse(r['created_at'] as String)),
    );
  }

  CentersCompanion _rowToCenterCompanion(Map<String, dynamic> r) {
    return CentersCompanion(
      id: Value(r['id'] as String),
      name: Value(r['name'] as String),
      city: Value(r['city'] as String),
      address: Value(r['address'] as String),
      lat: Value((r['lat'] as num).toDouble()),
      lng: Value((r['lng'] as num).toDouble()),
      phone: Value(r['phone'] as String),
      hours: Value(r['hours'] as String),
      createdAt: Value(DateTime.parse(r['created_at'] as String)),
    );
  }
}

final syncServiceProvider =
    NotifierProvider<SyncService, bool>(SyncService.new);
