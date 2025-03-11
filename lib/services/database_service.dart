import "package:path/path.dart";
import "package:sqflite/sqflite.dart";

class DatabaseService {
  final _databaseName = "truth_or_drink.sql";

  // makes it so that there can only ever exist one instance of this class
  // (singleton pattern)
  final DatabaseService instance = DatabaseService._constructor();

  // makes the constructor private
  DatabaseService._constructor();

  Future<Database> getDatabase() async {
    final databasesDirectoryPath = await getDatabasesPath();
    final databasePath = join(databasesDirectoryPath, _databaseName);
    return openDatabase(databasePath);
  }
}
