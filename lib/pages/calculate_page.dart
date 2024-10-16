import "package:flutter/material.dart";
import 'package:lasku_applikaatio/tools/NavigationRail.dart';
import 'package:lasku_applikaatio/part.dart';
import 'package:lasku_applikaatio/tools/database.dart';
import 'package:drift/drift.dart' as drift;

class CalculatePage extends StatefulWidget {
  final String projectName;

  const CalculatePage({
  super.key, 
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
  int? _selectedPartIndex;
  
  String _product = '';
  String _unit = '';
  bool _unitMeasurementBool = true;  //true = cm, false = m;

  bool _isButton1Green = true;
  bool _isButton2Green = false;
  bool _showEditButton = false;
  bool _showDeleteButton = false;
  bool _showBackButton = false;
  bool _isTextControllerEditable = true;

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
  
  void _enableEditing(String projectName, int length, int width, int depth, int index) {    //When clicking on edit button on project
    setState(() {
      _newPartNameController.text = projectName;
      _lengthcontroller.text = length.toString();
      _widthcontroller.text = width.toString();
      _depthcontroller.text = depth.toString();
      _showEditButton = true;
      _selectedPartIndex = index;
      _showDeleteButton = true;
      _showBackButton = true;
      _isTextControllerEditable = true;	
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

  void _backButtonPress() {       //When clicking on back button
    setState(() {
      _newPartNameController.clear();
      _lengthcontroller.clear();
      _widthcontroller.clear();
      _depthcontroller.clear();
      _showBackButton = false;
      _showEditButton = false;
      _showDeleteButton = false;
      _isTextControllerEditable = true;
    });
  }
  void _showPartInfo(String projectName, int length, int width, int depth, int index) {    //When clicking on edit button on project
    setState(() {
      _newPartNameController.text = projectName;
      _lengthcontroller.text = length.toString();
      _widthcontroller.text = width.toString();
      _depthcontroller.text = depth.toString();
      _showEditButton = false;
      _selectedPartIndex = index;
      _showDeleteButton = false;
      _showBackButton = true;
      _isTextControllerEditable = false;
    });
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
  Future<void> _updatePart(int partId, int projectId, String newTitle, double length, double width, double depth) async {
    await database.update(database.partData).replace(
      PartDataData(id: partId, projectId: projectId, partName: newTitle, length: length, width: width, depth: depth),
    );
    await _fetchProjectsFromDatabase();
  }
  void _deletePartData() {    //When clicking on delete button
    setState(() {
      _newPartNameController.clear();
      _lengthcontroller.clear();
      _widthcontroller.clear();
      _depthcontroller.clear();
      _showBackButton = false;
      _showEditButton = false;
      _showDeleteButton = false;
      _isTextControllerEditable = true;
    });
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
                          onEditTap: () => _enableEditing(part.partName, part.length.toInt(), part.width.toInt(), part.depth.toInt(), index),
                          onCardTap: () => _showPartInfo(part.partName, part.length.toInt(), part.width.toInt(), part.depth.toInt(), index),
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
                    ),
                    readOnly: !_isTextControllerEditable,
                    style: TextStyle(color: _isTextControllerEditable ? Colors.black : Colors.grey),
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
                    ),
                    readOnly: !_isTextControllerEditable,
                    style: TextStyle(color: _isTextControllerEditable ? Colors.black : Colors.grey),
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
                    ),
                    readOnly: !_isTextControllerEditable,
                    style: TextStyle(color: _isTextControllerEditable ? Colors.black : Colors.grey),
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
                    ),
                    readOnly: !_isTextControllerEditable,
                    style: TextStyle(color: _isTextControllerEditable ? Colors.black : Colors.grey),
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
                SizedBox(height: 15),
                if (_showBackButton) 
                  ElevatedButton(
                    onPressed: _backButtonPress,
                    child: Text('Takaisin'),
                  ),
                  if (_showDeleteButton) 
                  ... [ 
                    SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Haluatko varmasti poistaa osan?"),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        await database.deletePartData(partList[_selectedPartIndex!].id);
                                        _deletePartData();
                                        await _fetchPartsForProject();
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
                      child: Text('Poista Osa', style: TextStyle(color: Colors.white)), 
                    ), 
                  ],
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
                          child: Text('cm\u00B3', style: TextStyle(color: Colors.white)), 
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
                            child: Text('m\u00B3', style: TextStyle(color: Colors.white)),                          
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
                      if (_showEditButton) {
                        _updatePart(partList[_selectedPartIndex!].id, projectId!, 
                        _newPartNameController.text, 
                        double.parse(_lengthcontroller.text), 
                        double.parse(_widthcontroller.text), 
                        double.parse(_depthcontroller.text));
                      }
                      else {
                        await database.into(database.partData).insert(
                          PartDataCompanion(
                            partName: drift.Value(_newPartNameController.text),
                            length: drift.Value(double.parse(_lengthcontroller.text)),
                            width: drift.Value(double.parse(_widthcontroller.text)),
                            depth: drift.Value(double.parse(_depthcontroller.text)),
                            projectId: drift.Value(projectId ?? 0),
                          ),
                        );
                      }
                      await _fetchPartsForProject();
                      setState(() {
                        _newPartNameController.clear();
                        _lengthcontroller.clear();
                        _widthcontroller.clear();
                        _depthcontroller.clear();
                      });
                    }
                  },
                  child: Text(_showEditButton ? "Muokkaa Osaa" : "Lisää Osa"),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    List<Part> parts = partList.map((partData) {
                      return Part(
                        partName: partData.partName,
                        length: partData.length.toInt(),
                        width: partData.width.toInt(),
                        depth: partData.depth.toInt(),
                        onEditTap: () {},
                      );
                    }).toList();
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => NavigationRailWidget(
                          initialSelectedPage: 2,
                          selectedParts: parts,
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
                      : 'Kokonaismäärä: ${partList.fold<double>(0.0, (prev, part) => prev + part.length * part.width * part.depth / 1000000).toStringAsFixed(3)} m\u00B3',
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