import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import 'package:drift/native.dart';
//import 'package:drift_flutter/drift_flutter.dart';
//import 'package:path_provider/path_provider.dart';
//import 'package:sqlite3/sqlite3.dart';
//import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'database.g.dart';

class ProjectData extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get projectName => text().named('Name')();
  DateTimeColumn get createdAt => dateTime().nullable()();
}

class PartData extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get projectId => integer().customConstraint('REFERENCES project(id)')();
  TextColumn get partName => text()();
  RealColumn get length => real()();
  RealColumn get width => real()();
  RealColumn get depth => real()();
}

@DriftDatabase(tables: [ProjectData, PartData])
  class AppDatabase extends _$AppDatabase {
    AppDatabase() : super(_openConnection());

    @override
    int get schemaVersion => 1;

    static LazyDatabase _openConnection() {
      return LazyDatabase(() async {
        final directory = Directory.current;

        final dbFolder = p.join(directory.path, 'data');
        final folder = Directory(dbFolder);
          if (!await folder.exists()) {
            await folder.create(recursive: true);
          }
        final dbPath = p.join(dbFolder, 'values.sqlite');

        return NativeDatabase(File(dbPath));
      });
    }
  Future<void> initializeDefaultProject() async {
      final existingProjects = await select(projectData).get();
      if (existingProjects.isEmpty) {
        await into(projectData).insert(
          ProjectDataCompanion(
            projectName: Value("TestProject"),
            createdAt: Value(DateTime.now()),
          ),
        );
      }
    }
  
  Future<void> initializeDefaultPart() async {
    final existingParts = await select(partData).get();
    if (existingParts.isEmpty) {
      await into(partData).insert(
        PartDataCompanion(
          projectId: Value(1),
          partName: Value("Default Part"),
          length: Value(100.0),
          width: Value(50.0),
          depth: Value(25.0),
        ),
      );
    }
  }
  Future<List<PartDataData>> fetchPartsByProjectId(int projectId) async {
  return await (select(partData)
        ..where((tbl) => tbl.projectId.equals(projectId)))
      .get();
}
}