import 'package:flutter/material.dart';

class StateDropDownButton extends StatefulWidget {
  @override
  StateDropDownButtonState createState() {
    return StateDropDownButtonState();
  }
}

class StateDropDownButtonState extends State<StateDropDownButton> {
// Set the initial selection for the stateDropDownBox
  String stateDropDownValue = 'NSW';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: stateDropDownValue,
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
          stateDropDownValue = newValue;
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
