import 'package:flutter/material.dart';
import 'package:lasku_applikaatio/pages/calculate_page.dart';
import 'package:lasku_applikaatio/pages/page_2.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => MainAppState();
}

class MainAppState extends State<MainApp> {

  int _selectedIndex = 0;
  double groupAlignment = -1.0;
  List _pages = [
    CalculatePage(),
    Page2(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Row(
        children: [
            NavigationRail(
              selectedIndex: _selectedIndex,
              groupAlignment: groupAlignment,
              onDestinationSelected: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.calculate),
                  label: Text('Laske'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.print),
                  label: Text('Tulosta'),
                ),
              ],
            ),
            const VerticalDivider(thickness: 1, width: 1, color: Colors.grey),
            Expanded(
              child: Scaffold(
                body: _pages[_selectedIndex]
              )
            )
        ],
      ),
      );
  }
}
