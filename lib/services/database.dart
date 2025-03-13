import "package:drift/drift.dart";
import "package:drift_flutter/drift_flutter.dart";
import "package:path_provider/path_provider.dart";
import "package:truth_or_drink/models/cards.dart";
import "package:truth_or_drink/models/decks.dart";

part "database.g.dart";

mixin BaseTableMixin on Table {
  // Primary key column
  late final id = integer().autoIncrement()();
}

@DriftDatabase(tables: [Decks, Cards])
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

  Stream<List<Deck>> watchAllDecks() => select(decks).watch();
  Future insertDeck(String title) async =>
      await into(decks).insert(DecksCompanion.insert(title: title));
  Future deleteDeck(int id) async =>
      await (delete(decks)..where((deck) => deck.id.equals(id))).go();

  Stream<List<Card>> watchCardsFromDeck(int id) =>
      (select(cards)..where((card) => card.deck.equals(id))).watch();
  Future insertCard(String question, int deckId) async => await into(
    cards,
  ).insert(CardsCompanion.insert(question: question, deck: deckId));
  Future deleteCard(int id) async =>
      await (delete(cards)..where((card) => card.id.equals(id))).go();
}
