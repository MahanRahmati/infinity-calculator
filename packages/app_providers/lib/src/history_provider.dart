import 'package:app_database/app_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'db_provider.dart';

part 'history_provider.g.dart';

@riverpod
class History extends _$History {
  late final Database _db;
  static const String _dbName = 'history';

  @override
  Future<List<HistoryData>> build() async {
    _db = await ref.watch(
      DbProvider(
        dbName: _dbName,
        createStatements: const <String>[
          '''
        CREATE TABLE IF NOT EXISTS $_dbName (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          expression TEXT NOT NULL,
          result TEXT NOT NULL,
          timestamp INTEGER NOT NULL
        )
        '''
        ],
      ).future,
    );
    return _getHistory();
  }

  List<HistoryData> _getHistory() {
    const String statement = 'SELECT * FROM $_dbName ORDER BY timestamp DESC';
    final ResultSet result = _db.select(statement);
    final List<HistoryData> history = result.map((final Row row) {
      return HistoryData.fromMap(row);
    }).toList();
    return history;
  }

  void addCalculation(final String expression, final String result) {
    const String statement =
        'INSERT INTO $_dbName (expression, result, timestamp) VALUES (?,?,?)';
    _db.execute(
      statement,
      <Object?>[expression, result, DateTime.now().millisecondsSinceEpoch],
    );
    state = AsyncValue<List<HistoryData>>.data(_getHistory());
  }

  void clearHistory() {
    const String statement = 'DELETE FROM $_dbName';
    _db.execute(statement);
    state = const AsyncValue<List<HistoryData>>.data(<HistoryData>[]);
  }
}

class HistoryData {
  HistoryData({
    required this.expression,
    required this.result,
    required this.timestamp,
  });

  factory HistoryData.fromMap(final Map<String?, dynamic> map) {
    return HistoryData(
      expression: map['expression'] as String,
      result: map['result'] as String,
      timestamp: map['timestamp'] as int,
    );
  }

  final String expression;
  final String result;
  final int timestamp;
}
