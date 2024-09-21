import 'package:flutter/material.dart';
import 'package:lasku_applikaatio/project.dart';
import 'package:lasku_applikaatio/part.dart';
import 'package:lasku_applikaatio/tools/NavigationRail.dart';

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

  List projectList = [
    ["Jeren Omakotitalo", <Part>[]],
    ["Sirpan Kerrostalo", <Part>[]],
    ["Jukan Mökki", <Part>[]],
  ];

  void _showProjectInfo(String projectName, int index) {
    setState(() {
      _newProjectNameController.text = projectName;
      _isTextControllerEditable = false;
      _showBackButton = true;
      _selectedProjectIndex = index;
      _showEditButton = false;
      _showDeleteButton = false;
    });
  }

  void _enableEditing(String projectName, int index) {
    setState(() {
      _newProjectNameController.text = projectName;
      _isTextControllerEditable = true;
      _showBackButton = true;
      _showEditButton = true;
      _selectedProjectIndex = index;
      _showDeleteButton = true;
    });
  }

  void _removeProject() {
    setState(() {
      _newProjectNameController.clear();
      _isTextControllerEditable = true;
      _showBackButton = false;
      _showEditButton = false;
      _showDeleteButton = false;
    });
  }
  void _deleteProject() {
    setState(() {
      projectList.removeAt(_selectedProjectIndex!);
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
                          projectName: projectList[index][0], 
                          parts: projectList[index][1],
                          onCardTap: (name) => _showProjectInfo(name, index),
                          onEditTap: (name) => _enableEditing(name, index),
                        );
                      },
                    )),
                ),
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
                        onPressed: _removeProject,
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
                          projectList[_selectedProjectIndex!][0] = _newProjectNameController.text;
                        } } else {
                          projectList.add([_newProjectNameController.text, <Part>[]]);
                      _newProjectNameController.clear();
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
                                    _deleteProject();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Kyllä", style: TextStyle(color: Colors.red)),
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
                  child: Text('Poista Projekti'),
                ),
                SizedBox(height: 10),
                SizedBox(height: 100),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                     context,
                     PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => NavigationRailWidget(initialSelectedPage: 1),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
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