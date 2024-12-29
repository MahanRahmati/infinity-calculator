import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

/// The database service.
class DatabaseService {
  DatabaseService._();

  static final DatabaseService instance = DatabaseService._();
  final Map<String, Database> _databases = <String, Database>{};

  /// Returns a database instance.
  Future<Database> getDatabase({
    required final String name,
    required final List<String> createStatements,
  }) async {
    if (_databases.containsKey(name)) {
      return _databases[name]!;
    }

    final Directory appDir = await getApplicationDocumentsDirectory();
    final String dbPath = path.join(appDir.path, '$name.db');

    final Database db = sqlite3.open(dbPath);

    // Execute create statements if tables don't exist
    for (int i = 0; i < createStatements.length; i++) {
      final String statement = createStatements[i];
      db.execute(statement);
    }

    _databases[name] = db;
    return db;
  }

  /// Closes a database instance.
  void closeDatabase(final String name) {
    if (_databases.containsKey(name)) {
      _databases[name]!.dispose();
      _databases.remove(name);
    }
  }

  /// Closes all database instances.
  void closeAllDatabases() {
    for (final Database db in _databases.values) {
      db.dispose();
    }
    _databases.clear();
  }
}
