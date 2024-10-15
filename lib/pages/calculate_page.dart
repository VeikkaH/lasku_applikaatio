import "package:flutter/material.dart";
import 'package:lasku_applikaatio/tools/NavigationRail.dart';
import 'package:lasku_applikaatio/part.dart';
import 'package:lasku_applikaatio/tools/database.dart';
import 'package:drift/drift.dart' as drift;
class CalculatePage extends StatefulWidget {
  final List<Part> parts;
  final String projectName;

  const CalculatePage({
  super.key, 
  required this.parts,
  required this.projectName,
  });

  @override
  State<CalculatePage> createState() => _CalculatePageState();
}

class _CalculatePageState extends State<CalculatePage> {

  final _newPartNameController = TextEditingController();
  final _lengthcontroller = TextEditingController();
  final _widthcontroller = TextEditingController();
  final _depthcontroller = TextEditingController();

  String _product = '';
  String _unit = '';
  bool _unitMeasurementBool = true;  //true = cm, false = m;

  bool _isButton1Green = true;
  bool _isButton2Green = false;

  late AppDatabase database;
  List<ProjectDataData> projectList = [];
  List<PartDataData> partList = [];
  int? projectId;

  void _toggleButton1() {
    setState(() {
      if (!_isButton1Green) {
        _isButton1Green = true;
        _isButton2Green = false;
      }
    });
  }

  void _toggleButton2() {
    setState(() {
      if (!_isButton2Green) {
        _isButton1Green = false;
        _isButton2Green = true;
      }
    });
  }

  void calculateProduct() {
    if (_lengthcontroller.text.isNotEmpty &&
        _widthcontroller.text.isNotEmpty &&
        _depthcontroller.text.isNotEmpty) {
      double product = double.parse(_lengthcontroller.text) *
          double.parse(_widthcontroller.text) *
          double.parse(_depthcontroller.text);

    if (_unitMeasurementBool == false) {
        product = product / 1000000;
      }
      setState(() {
        _product = '$product';
      });
    }
  }

  @override
  
  void initState() {
    super.initState();
    database = AppDatabase();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    await _fetchProjectsFromDatabase();
    await _fetchPartsForProject();
  }

  Future<void> _fetchProjectsFromDatabase() async {
    final projects = await database.fetchProjectsFromDatabase();
    setState(() {
      projectList = projects;
    });
  }
  Future<void> _updateProject(int projectId, String newTitle) async {
    await database.update(database.projectData).replace(
      ProjectDataData(id: projectId, projectName: newTitle),
    );
    await _fetchProjectsFromDatabase();
  }

  Future<void> _deleteProject(int projectId) async {
    await database.delete(database.projectData).delete(
      ProjectDataData(id: projectId, projectName: ''),
    );
    await _fetchProjectsFromDatabase();
  }

  Future<List<PartDataData>> _fetchPartsForProject() async {
    try {
    final project = projectList.firstWhere(
      (project) => project.projectName == widget.projectName,
      orElse: () {
        throw Exception('Project not found');
      },
    );
    projectId = project.id;
    if (projectId == null) {
      print('Error: projectId is null');
      return [];
    }

    final fetchedParts = await database.fetchPartsByProjectId(projectId!);
    setState(() {
      partList = fetchedParts;
    });
    return fetchedParts;  //Ensure no null return

  } catch (e) {
    print('Error: $e');
    setState(() {
      partList = [];
    });
    return [];
  }
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
                Text('${widget.projectName} osat'),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 500,
                    width: 400,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Colors.grey
                      )
                    ),
                    child: ListView.builder(
                      itemCount: partList.length,
                      itemBuilder: (context, index) {
                        final part = partList[index];
                        return Part(
                          partName: part.partName,
                          length: part.length.toInt(),
                          width: part.width.toInt(),
                          depth: part.depth.toInt(),
                        );
                      },
                    ),  
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text('Syötä projektin osan tiedot',
                style: TextStyle(fontSize: 30)),
                SizedBox(height: 20),
                SizedBox(
                  width: 250,
                  child: TextField(
                    controller: _newPartNameController,
                    decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Osan Nimi',
                    )
                  )
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 250,
                  child: TextField(
                    controller: _lengthcontroller,
                    decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Pituus cm',
                    )
                  )
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 250,
                  child: TextField(
                    controller: _widthcontroller,
                    decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Leveys cm',
                    )
                  )
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 250,
                  child: TextField(
                    controller: _depthcontroller,
                    decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Syvyys cm',
                    )
                  )
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_unit == '') {
                      _unit = 'cm\u00B3';
                    }
                    calculateProduct();
                  },
                  child: Text('Laske tilavuus'),
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Maata on poistettava $_product $_unit'),
                    SizedBox(width: 20),
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _toggleButton1();
                            setState(() {
                              _unit = 'cm\u00B3';
                              _unitMeasurementBool = true;
                            });
                            calculateProduct();
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(75, 37),
                            backgroundColor: _isButton1Green ? Colors.green : Colors.blue,  // Update button color
                            ),
                          child: Text('cm\u00B3'),
                        ),
                        SizedBox(height: 5),
                        ElevatedButton(
                            onPressed: () {
                              _toggleButton2();
                              setState(() {
                                _unit = 'm\u00B3';
                                _unitMeasurementBool = false;
                              });
                            calculateProduct();
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(75, 37),
                            backgroundColor: _isButton2Green ? Colors.green : Colors.blue,  // Update button color
                            ),
                            child: Text('m\u00B3'),                          
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_newPartNameController.text.isNotEmpty &&
                      _lengthcontroller.text.isNotEmpty &&
                      _widthcontroller.text.isNotEmpty &&
                      _depthcontroller.text.isNotEmpty) {

                      await database.into(database.partData).insert(
                        PartDataCompanion(
                          partName: drift.Value(_newPartNameController.text),
                          length: drift.Value(double.parse(_lengthcontroller.text)),
                          width: drift.Value(double.parse(_widthcontroller.text)),
                          depth: drift.Value(double.parse(_depthcontroller.text)),
                          projectId: drift.Value(projectId ?? 0),
                        ),
                      );

                      await _fetchPartsForProject();
                      setState(() {
                        _newPartNameController.clear();
                        _lengthcontroller.clear();
                        _widthcontroller.clear();
                        _depthcontroller.clear();
                      });
                    }
                  },
                  child: Text('Lisää Osa'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => NavigationRailWidget(
                          initialSelectedPage: 2,
                          selectedParts: widget.parts,
                          projectName: widget.projectName,
                        ),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  },
                  child: Text('Siirry Printtaamaan'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Text('Maata on poistettava yhteensä: '),
                  SizedBox(height: 15),
                  Container(
                        height: 300,
                        width: 400,
                         decoration: BoxDecoration(
                        border: Border.all(
                        width: 2,
                        color: Colors.grey
                      )
                    ),
                    child: ListView.builder(
                      itemCount: partList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(partList[index].partName),
                            Text(
                              '${partList[index].length * partList[index].width * partList[index].depth} cm\u00B3',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Text(_unitMeasurementBool
                      ? 'Kokonaismäärä: ${partList.fold<double>(0.0, (prev, part) => prev + part.length * part.width * part.depth)} cm\u00B3'
                      : 'Kokonaismäärä: ${partList.fold<double>(0.0, (prev, part) => prev + part.length * part.width * part.depth / 1000000)} m\u00B3',
                      style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}