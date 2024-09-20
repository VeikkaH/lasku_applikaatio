import 'package:flutter/material.dart';

class PrintPage extends StatelessWidget {
  const PrintPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 300,
        width: 300,
        color:Colors.blue,
        child: Text("Tässä näet projektin tiedot ja voit tulostaa ne"),
      )
    );
  }
}