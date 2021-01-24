import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StateDropDownButton extends StatefulWidget {
  // Set the initial selection for the stateDropDownBox
  String stateDropDownValue = 'NSW';

  @override
  StateDropDownButtonState createState() {
    return StateDropDownButtonState();
  }
}

class StateDropDownButtonState extends State<StateDropDownButton> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.stateDropDownValue,
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
          widget.stateDropDownValue = newValue;
        });
      },
      items: <String>['NSW', 'QLD', 'SA', 'VIC', 'WA', 'NT', 'TAS', 'ACT']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
