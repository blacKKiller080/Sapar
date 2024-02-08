import 'package:drift/drift.dart';
import 'package:flutter_wrap_architecture/src/core/database/drift/connection/open_connection_stub.dart'
    if (dart.library.io) 'package:flutter_wrap_architecture/src/core/database/drift/connection/open_connection_io.dart'
    if (dart.library.html) 'package:flutter_wrap_architecture/src/core/database/drift/connection/open_connection_web.dart'
    as connection;

part 'app_database.g.dart';

@DriftDatabase()
class AppDatabase extends _$AppDatabase {
  AppDatabase({required String name}) : super(connection.openConnection(name));

  @override
  int get schemaVersion => 1;
}
