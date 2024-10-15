import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import 'package:drift/native.dart';
part 'database.g.dart';

class ProjectData extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get projectName => text().named('Name')();
}

class PartData extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get projectId => integer().customConstraint('REFERENCES project_data(id) ON DELETE CASCADE NOT NULL')();
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

  Future<List<ProjectDataData>> fetchProjectsFromDatabase() async {
    final projects = await select(projectData).get();
    return projects;
  }
  
  Future<List<PartDataData>> fetchPartsByProjectId(int projectId) async {
  return await (select(partData)
        ..where((tbl) => tbl.projectId.equals(projectId)))
      .get();
}
}