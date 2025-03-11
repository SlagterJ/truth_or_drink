import "package:drift/drift.dart";
import "package:drift_flutter/drift_flutter.dart";
import "package:path_provider/path_provider.dart";

part "database.g.dart";

mixin BaseTableMixin on Table {
  // Primary key column
  late final id = integer().autoIncrement()();
}

class Decks extends Table with BaseTableMixin {
  late final title = text().withLength(min: 4, max: 16)();
}

class Cards extends Table with BaseTableMixin {
  late final question = text().withLength(min: 6, max: 64)();
  late final deck = integer().references(Decks, #id)();
}

@DriftDatabase(tables: [Cards])
class AppDatabase extends _$AppDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: "truth_or_drink",
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
    );
  }
}
