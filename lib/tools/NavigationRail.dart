import 'package:flutter/material.dart';
import 'package:lasku_applikaatio/pages/calculate_page.dart';
import 'package:lasku_applikaatio/pages/printpage.dart';
import 'package:lasku_applikaatio/pages/homepage.dart';
import 'package:lasku_applikaatio/part.dart';

class NavigationRailWidget extends StatefulWidget {
  final int initialSelectedPage;
  final List<Part> selectedParts;
  final String projectName;

  NavigationRailWidget({super.key, 
  required this.initialSelectedPage,
  required this.selectedParts,
  required this.projectName,
  });

  @override
  State<NavigationRailWidget> createState() => _NavigationRailWidgetState();
}

class _NavigationRailWidgetState extends State<NavigationRailWidget> {

  int _selectedPage = 0;
  double groupAlignment = -1.0;
  late List _pages;

  @override

  void initState() {
    super.initState();
    _selectedPage = widget.initialSelectedPage;
    _pages = [
      HomePage(),
      CalculatePage(parts: widget.selectedParts, projectName: widget.projectName),
      PrintPage(),
    ];
  }

  void setSelectedPage(int value) {
    setState(() {
      _selectedPage = value;
      if (_selectedPage == 1) {
        _pages[1] = CalculatePage(parts: widget.selectedParts, projectName: widget.projectName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
            NavigationRail(
              selectedIndex: _selectedPage,
              groupAlignment: groupAlignment,
              backgroundColor: Color.fromARGB(161, 223, 241, 255),
              onDestinationSelected: (int index) {
                  setSelectedPage(index);
                },
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Koti'),
                ),
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
                body: _pages[_selectedPage]
              )
            )
        ],
      ),
    );
  }
}