import 'package:app_database/app_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'db_provider.g.dart';

@riverpod
Future<Database> db(
  final Ref ref, {
  required final String dbName,
  required final List<String> createStatements,
}) async {
  final Database db = await DatabaseService.instance.getDatabase(
    name: dbName,
    createStatements: createStatements,
  );

  ref.onDispose(() {
    DatabaseService.instance.closeDatabase(dbName);
  });

  return db;
}
