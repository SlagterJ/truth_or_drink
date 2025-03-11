import "package:drift/drift.dart";
import "package:truth_or_drink/services/database.dart";

class Decks extends Table with BaseTableMixin {
  late final title = text().withLength(min: 4, max: 16)();
}
