import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NumberDropDownButton extends StatefulWidget {
  // Set the initial selection for the stateDropDownBox
  String numberDropDownValue = '1';

  @override
  NumberDropDownButtonState createState() {
    return NumberDropDownButtonState();
  }
}

class NumberDropDownButtonState extends State<NumberDropDownButton> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.numberDropDownValue,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.green),
      underline: Container(
        height: 2,
        color: Colors.greenAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          widget.numberDropDownValue = newValue;
        });
      },
      items: <String>['1', '2', '3', '4', '5']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
