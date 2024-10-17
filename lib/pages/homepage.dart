import 'package:flutter/material.dart';
import 'package:lasku_applikaatio/project.dart';
import 'package:lasku_applikaatio/part.dart';
import 'package:lasku_applikaatio/tools/NavigationRail.dart';
import 'package:lasku_applikaatio/tools/database.dart';
import 'package:drift/drift.dart' as drift;
import 'package:lasku_applikaatio/tools/database_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _newProjectNameController = TextEditingController();
  bool _isTextControllerEditable = true;
  bool _showBackButton = false;
  bool _showEditButton = false;
  bool _showDeleteButton = false;
  int? _selectedProjectIndex;
  
  final DatabaseService db = DatabaseService();
  List<ProjectDataData> projectList = [];

  @override
  void initState() {
    super.initState();
    _updateDatabase();
  }

  Future<void> _updateDatabase() async {
    projectList = await db.fetchProjectsFromDatabase();
    setState(() {});
  }

  void _showProjectInfo(String projectName, int index) {    //When clicking on project
    setState(() {
      _newProjectNameController.text = projectName;
      _isTextControllerEditable = false;
      _showBackButton = true;
      _selectedProjectIndex = index;
      _showEditButton = false;
      _showDeleteButton = false;
    });
  }

  void _enableEditing(String projectName, int index) {    //When clicking on edit button on project
    setState(() {
      _newProjectNameController.text = projectName;
      _isTextControllerEditable = true;
      _showBackButton = true;
      _showEditButton = true;
      _selectedProjectIndex = index;
      _showDeleteButton = true;
    });
  }
  void _deleteProjectData(int projectId) {    //When clicking on delete button
    setState(() {
      db.deleteProject(projectId);
      _newProjectNameController.clear();
      _isTextControllerEditable = true;
      _showBackButton = false;
      _showEditButton = false;
      _showDeleteButton = false;
    });
    _updateDatabase();
  }

  void _backButtonPress() {       //When clicking on back button
    setState(() {
      _newProjectNameController.clear();
      _isTextControllerEditable = true;
      _showBackButton = false;
      _showEditButton = false;
      _showDeleteButton = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            Column(
              children: [
                SizedBox(height: 10),
                Text("Projektit"),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 600,
                    width: 400,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Colors.grey
                      )
                    ),
                    child: ListView.builder(
                      itemCount: projectList.length,
                      itemBuilder: (context, index) {
                        return Project(
                          projectName: projectList[index].projectName,
                          onCardTap: (name) => _showProjectInfo(name, index),
                          onEditTap: (name) => _enableEditing(name, index),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
            
            Column(
              children: [
                SizedBox(height: 50),
                Text("LASKENTAOHJELMA"),
                SizedBox(height: 50),
                Row(
                  children: [
                    SizedBox(
                      width: 250,
                      child: TextField(
                        controller: _newProjectNameController,
                        decoration: InputDecoration(
                         border: OutlineInputBorder(),
                         labelText: 'Uuden Projektin Nimi',
                        ),
                        readOnly: !_isTextControllerEditable,
                        style: TextStyle(color: _isTextControllerEditable ? Colors.black : Colors.grey),
                      )
                    ),
                    SizedBox(width: 15),
                    if (_showBackButton)
                      ElevatedButton(
                        onPressed: _backButtonPress,
                        child: Text('Takaisin'),
                      ),
                  ],
                ),
                SizedBox(height: 10),
                if (!_showBackButton || (_showBackButton && _showEditButton))
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (_showEditButton) {
                        if (_selectedProjectIndex != null) {
                          final projectId = projectList[_selectedProjectIndex!].id;
                          db.updateProject(projectId, _newProjectNameController.text);
                          _updateDatabase();
                        } } else {
                          setState (() {
                            db.addProject(ProjectDataCompanion(projectName: drift.Value(_newProjectNameController.text)));
                            _newProjectNameController.clear();
                            _updateDatabase();
                            }

                          );
                        }
                    });
                  },
                  child: Text(_showEditButton ? "Muokkaa Nimeä" : "Luo Uusi Projekti"),
                ),
                SizedBox(height: 15),
                if (_showDeleteButton)
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Haluatko varmasti poistaa projektin?"),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    _deleteProjectData(projectList[_selectedProjectIndex!].id);
                                    Navigator.of(context).pop();
                                  },
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                  child: Text("Kyllä", style: TextStyle(color: Colors.white)),
                                ),
                                SizedBox(width: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Ei"),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text('Poista Projekti', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(height: 10),
                SizedBox(height: 100),
                ElevatedButton(
                  onPressed: () async {
                    final BuildContext localContext = context;
                    List<PartDataData> partList = await db.fetchPartsForProject(projectList[_selectedProjectIndex!].projectName);
                    List<Part> parts = partList.map((partData) {
                      return Part(
                      partName: partData.partName,
                      length: partData.length.toInt(),
                      width: partData.width.toInt(),
                      depth: partData.depth.toInt(),
                    );
                    }).toList();

                    if (mounted) {
                      Navigator.push(
                        localContext,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => NavigationRailWidget(
                            initialSelectedPage: 1, 
                            selectedParts: parts,
                            projectName: projectList[_selectedProjectIndex!].projectName,
                          ),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    }
                  },
                  child: Text('Siirry Laskentasivulle'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}