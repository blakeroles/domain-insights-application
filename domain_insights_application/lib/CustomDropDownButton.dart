import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomDropDownButton extends StatefulWidget {
  // Set the initial selection for the stateDropDownBox
  String dropDownValue;
  List<String> dropDownValues;

  CustomDropDownButton(String value, List<String> values) {
    this.dropDownValue = value;
    this.dropDownValues = values;
  }

  @override
  CustomDropDownButtonState createState() {
    return CustomDropDownButtonState();
  }
}

class CustomDropDownButtonState extends State<CustomDropDownButton> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.dropDownValue,
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
          widget.dropDownValue = newValue;
        });
      },
      items:
          widget.dropDownValues.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
