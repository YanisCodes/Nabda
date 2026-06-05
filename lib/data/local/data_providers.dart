import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/center.dart' as model;
import '../models/event.dart';

/// Cache en mémoire chargé depuis SQLite au démarrage.
/// Mis à jour après une sync Supabase (Phase 10).
final eventsListProvider = StateProvider<List<Event>>((_) => const []);
final centersListProvider =
    StateProvider<List<model.Center>>((_) => const []);
