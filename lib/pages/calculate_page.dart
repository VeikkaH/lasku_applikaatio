import "package:flutter/material.dart";

class CalculatePage extends StatefulWidget {

  const CalculatePage({super.key});

  @override
  State<CalculatePage> createState() => _CalculatePageState();
}

class _CalculatePageState extends State<CalculatePage> {
  final _lengthcontroller = TextEditingController();

  final _widthcontroller = TextEditingController();

  final _depthcontroller = TextEditingController();

  String _product = '';
  String _unit = '';
  bool _unitMeasurementBool = true;  //true = cm, false = m;

  void calculateProduct() {
    if (_lengthcontroller.text.isNotEmpty &&
        _widthcontroller.text.isNotEmpty &&
        _depthcontroller.text.isNotEmpty) {
      double product = double.parse(_lengthcontroller.text) *
          double.parse(_widthcontroller.text) *
          double.parse(_depthcontroller.text);

    if (_unitMeasurementBool == false) {
        product = product / 1000000;
      }
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
                 controller: _lengthcontroller,
                 decoration: InputDecoration(
                 border: OutlineInputBorder(),
                 labelText: 'Pituus cm',
                 )
                )
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 250,
                child: TextField(
                 controller: _widthcontroller,
                 decoration: InputDecoration(
                 border: OutlineInputBorder(),
                 labelText: 'Leveys cm',
                 )
                )
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 250,
                child: TextField(
                 controller: _depthcontroller,
                 decoration: InputDecoration(
                 border: OutlineInputBorder(),
                 labelText: 'Syvyys cm',
                 )
                )
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: calculateProduct,
                child: Text('Laske tilavuus'),
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Maata on poistettava $_product $_unit'),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _unit = 'cm^3';
                            _unitMeasurementBool = true;
                          });
                          calculateProduct();
                        },
                       child: Text('cm^3'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(213, 12, 236, 169),
                        ),
                        onPressed: () {
                          setState(() {
                            _unit = 'm^3';
                            _unitMeasurementBool = false;
                          });
                          calculateProduct();
                        },
                       child: Text('m^3'),
                      ),
                    ],
                  ),
                ],
              ),
            ]
          ),
        ),
      );
  }
}