import 'package:flutter/material.dart';
import 'tools/NavigationRail.dart';
import 'part.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => MainAppState();
}

class MainAppState extends State<MainApp> {
  List<Part> selectedParts = [];
  String projectName = '';
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NavigationRailWidget(
        initialSelectedPage: 0,
        selectedParts: selectedParts,
        projectName: projectName,
      ),
    );
  }
}
