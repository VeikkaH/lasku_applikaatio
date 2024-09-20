import 'package:flutter/material.dart';

class Part extends StatelessWidget {

  final String partName;
  final int length;
  final int width;
  final int depth;

  Part({
    super.key,
    required this.partName,
    required this.length,
    required this.width,
    required this.depth
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
        child: Text('$partName | $length | $width | $depth'),
      )
    );
  }
}