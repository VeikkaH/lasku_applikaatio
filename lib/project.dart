import 'package:flutter/material.dart';
import 'package:lasku_applikaatio/pages/homepage.dart';
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
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
          child: Row(
            children: [
              Text(projectName),
              Spacer(),
              Container(
                margin: EdgeInsets.only(right: 10),
                  height: 22,
                  width: 22,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromARGB(255, 123, 209, 250),
                  ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                    },
                    borderRadius: BorderRadius.circular(5),
                    splashColor: Colors.blueAccent.withOpacity(0.3),
                    hoverColor: Colors.blue.withOpacity(0.2),
                    child: Icon(
                      Icons.edit,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}