import "database.dart";

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  final AppDatabase _database = AppDatabase();

  Future<List<ProjectDataData>> fetchProjectsFromDatabase() async {
    final projects = await _database.select(_database.projectData).get();
    return projects;
  }
  
  Future<List<PartDataData>> fetchPartsForProject(String projectName) async {
    try {

    final List<ProjectDataData> projectList = await fetchProjectsFromDatabase();
    final ProjectDataData project = projectList.firstWhere(
      (project) => project.projectName == projectName,
      orElse: () {
        throw Exception('Project not found');
      },
    );

    return await (_database.select(_database.partData)
        ..where((tbl) => tbl.projectId.equals(project.id)))
      .get();

  } catch (e) {
    print('Error: $e');
    return [];
  }
  }

  Future<void> updatePart(int partId, int projectId, String newTitle, double length, double width, double depth) async {
    await _database.update(_database.partData).replace(
      PartDataData(id: partId, projectId: projectId, partName: newTitle, length: length, width: width, depth: depth),
    );
  }

  Future<void> updateProject(int projectId, String newTitle) async {
    await _database.update(_database.projectData).replace(
      ProjectDataData(id: projectId, projectName: newTitle),
    );
  }

  Future<void> insertPartData(PartDataCompanion partData) async {
    await _database.into(_database.partData).insert(partData);
  }

  Future<void> addProject(ProjectDataCompanion projectName) async {
    await _database.into(_database.projectData).insert(projectName);
  }

  Future<void> deletePartData(int partId) async {
    await (_database.delete(_database.partData)..where((tbl) => tbl.id.equals(partId))).go();
  }
  
  Future<void> deleteProject(int projectId) async {
    await (_database.delete(_database.projectData)..where((tbl) => tbl.id.equals(projectId))).go();
  }
}