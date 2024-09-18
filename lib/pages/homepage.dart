import 'package:flutter/material.dart';
import 'package:lasku_applikaatio/project.dart';
import 'package:lasku_applikaatio/part.dart';
import 'package:lasku_applikaatio/pages/calculate_page.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _newProjectNameController = TextEditingController();

  List projectList = [
    ["Jeren Omakotitalo", <Part>[]],
    ["Sirpan Kerrostalo", <Part>[]],
    ["Jukan Mökki", <Part>[]],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            Column(
              children: [
                SizedBox(height: 10),
                Text("Projektit"),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 600,
                    width: 400,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Colors.grey
                      )
                    ),
                    child: ListView.builder(
                      itemCount: projectList.length,
                      itemBuilder: (context, index) {
                        return Project(
                          projectName: projectList[index][0], 
                          parts: projectList[index][1],
                        );
                      },
                    )),
                ),
              ],
            ),
            
            Column(
              children: [
                SizedBox(height: 50),
                Text("LASKENTAOHJELMA"),
                SizedBox(height: 50),
                SizedBox(
                  width: 250,
                  child: TextField(
                    controller: _newProjectNameController,
                    decoration: InputDecoration(
                     border: OutlineInputBorder(),
                     labelText: 'Uuden Projektin Nimi',
                    )
                  )
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      projectList.add([_newProjectNameController.text, <Part>[]]);
                    });
                  },
                  child: Text('Luo Uusi Projekti'),
                ),
                SizedBox(height: 100),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/calculate');
                  },
                  child: Text('Luo Uusi Projekti'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}