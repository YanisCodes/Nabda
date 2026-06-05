import 'package:drift/drift.dart';

import '../../../data/models/center.dart' as model;
import '../database.dart';

part 'centers_dao.g.dart';

@DriftAccessor(tables: [Centers])
class CentersDao extends DatabaseAccessor<AppDatabase> with _$CentersDaoMixin {
  CentersDao(super.db);

  Future<List<model.Center>> getAllModels() async {
    final rows = await select(centers).get();
    return rows.map((r) => r.toModel()).toList();
  }

  Future<List<model.Center>> getByCityModels(String city) async {
    final all = await getAllModels();
    return all
        .where((c) => c.city.toLowerCase() == city.toLowerCase())
        .toList();
  }

  Future<void> upsertAll(List<CentersCompanion> rows) async {
    await batch((b) => b.insertAllOnConflictUpdate(centers, rows));
  }
}
