import "package:flutter/material.dart";

class CalculatePage extends StatefulWidget {

  const CalculatePage({super.key});

  @override
  State<CalculatePage> createState() => _CalculatePageState();
}

class _CalculatePageState extends State<CalculatePage> {
   final controller1 = TextEditingController();

  final controller2 = TextEditingController();

  final controller3 = TextEditingController();

  String _product = '';

  void calculateProduct() {
    if (controller1.text.isNotEmpty &&
        controller2.text.isNotEmpty &&
        controller3.text.isNotEmpty) {
      final product = double.parse(controller1.text) *
          double.parse(controller2.text) *
          double.parse(controller3.text);
      setState(() {
        _product = '$product';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(31),
          child: Column(
            children: [
              Text('Syötä kuopan mitat',
              style: TextStyle(fontSize: 30)),
              SizedBox(height: 20),
              SizedBox(
                width: 250,
                child: TextField(
                 controller: controller1,
                 decoration: InputDecoration(
                 border: OutlineInputBorder(),
                 labelText: 'Pituus',
                 )
                )
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 250,
                child: TextField(
                 controller: controller2,
                 decoration: InputDecoration(
                 border: OutlineInputBorder(),
                 labelText: 'Leveys',
                 )
                )
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 250,
                child: TextField(
                 controller: controller3,
                 decoration: InputDecoration(
                 border: OutlineInputBorder(),
                 labelText: 'Syvyys',
                 )
                )
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: calculateProduct,
                child: Text('Laske tilavuus'),
              ),
              Text('Maata on poistettava $_product cm^3'),
            ]
          ),
        ),
      );
  }
}