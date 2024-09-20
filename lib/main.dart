import 'package:flutter/material.dart';
import 'package:lasku_applikaatio/pages/calculate_page.dart';
import 'package:lasku_applikaatio/pages/printpage.dart';
import 'package:lasku_applikaatio/pages/homepage.dart';
import 'tools/NavigationRail.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => MainAppState();
}

class MainAppState extends State<MainApp> {

  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
            '/home': (context) => HomePage(),
            '/calculate': (context) => CalculatePage(),
            '/print': (context) => PrintPage(),
          },
      home: NavigationRailWidget(initialSelectedPage: 0),
      );
  }
}
