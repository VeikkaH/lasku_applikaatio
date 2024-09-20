import 'package:flutter/material.dart';
import 'package:lasku_applikaatio/pages/calculate_page.dart';
import 'package:lasku_applikaatio/pages/printpage.dart';
import 'package:lasku_applikaatio/pages/homepage.dart';

class NavigationRailWidget extends StatefulWidget {
  final int initialSelectedPage;

  NavigationRailWidget({super.key, required this.initialSelectedPage});

  @override
  State<NavigationRailWidget> createState() => _NavigationRailWidgetState();
}

class _NavigationRailWidgetState extends State<NavigationRailWidget> {

  int _selectedPage = 0;
  double groupAlignment = -1.0;
  List _pages = [
    HomePage(),
    CalculatePage(),
    PrintPage(),
  ];
  
  @override

  void initState() {
    super.initState();
    _selectedPage = widget.initialSelectedPage;
  }

  void setSelectedPage(int value) {
    setState(() {
      _selectedPage = value;
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
              onDestinationSelected: (int index) {
                  setState(() {
                    _selectedPage = index;
                  });
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