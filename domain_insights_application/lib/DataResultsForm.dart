import 'package:domain_insights_application/DomainSuburbData.dart';
import 'package:domain_insights_application/MainTitleForm.dart';
import 'package:domain_insights_application/NavigationDrawer.dart';
import 'package:flutter/material.dart';

class DataResultsFormStateless extends StatelessWidget {
  // Declare a field to store the sent DomainSuburb data
  final DomainSuburbData dsd;

  DataResultsFormStateless({Key key, @required this.dsd}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final appTitle = 'iPropty';

    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
          drawer: NavigationDrawer(),
          appBar: AppBar(
            title: Text(appTitle),
          ),
          body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Table(children: [
                TableRow(children: [
                  TableCell(child: Text('Suburb')),
                  TableCell(child: Text(dsd.suburbName))
                ]),
                TableRow(children: [
                  TableCell(child: Text('State')),
                  TableCell(child: Text(dsd.suburbState))
                ]),
                TableRow(children: [
                  TableCell(child: Text('Number of available properties')),
                  TableCell(child: Text(dsd.noOfAvailableProperties.toString()))
                ]),
                TableRow(children: [
                  TableCell(child: Text('Median sold price')),
                  TableCell(child: Text(dsd.medianSoldPrice.toString()))
                ])
              ]))),
    );
  }
}

// Create the MainTitleForm widget
// class DataResultsForm extends StatefulWidget {
//   @override
//   DataResultsFormState createState() {
//     return DataResultsFormState();
//   }
// }

// Create the MainTitleFormState class
// class DataResultsFormState extends State<DataResultsForm> {
//   @override
//   Widget build(BuildContext context) {
//     // Build a Form widget using the _formKey created above
//     return Form(
//       child: Container(
//         width: 250.0,
//         height: 860.0,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Text("test"),
//           ],
//         ),
//       ),
//     );
//   }
// }
