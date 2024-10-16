import 'package:flutter/material.dart';

class Part extends StatelessWidget {

  final String partName;
  final int length;
  final int width;
  final int depth;
  final void Function()? onEditTap;
  final void Function()? onCardTap;

  Part({
    super.key,
    required this.partName,
    required this.length,
    required this.width,
    required this.depth,
    this.onEditTap,
    this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: onCardTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
          child: Row(
            children: [
              Text('$partName | $length | $width | $depth'),
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
                    onTap: onEditTap,
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