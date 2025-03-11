import "package:drift/drift.dart";
import "package:truth_or_drink/models/decks.dart";
import "package:truth_or_drink/services/database.dart";

class Cards extends Table with BaseTableMixin {
  late final question = text().withLength(min: 6, max: 64)();
  late final deck = integer().references(Decks, #id)();
}
