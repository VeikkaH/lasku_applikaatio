import 'package:flutter/material.dart';
import 'part.dart';

class Project extends StatelessWidget {

  final String projectName;
  final List<Part> parts;

  Project({
    super.key,
    required this.projectName,
    required this.parts,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(projectName)
    );
  }
}