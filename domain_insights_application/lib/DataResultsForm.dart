import 'package:domain_insights_application/DomainSuburb.dart';
import 'package:domain_insights_application/MainTitleForm.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class DataResultsFormStateless extends StatelessWidget {
  // Declare a field to store the sent DomainSuburb data
  final DomainSuburb ds;

  DataResultsFormStateless({Key key, @required this.ds}) : super(key: key);

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
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text(appTitle),
                  decoration: BoxDecoration(
                    color: Colors.green,
                  ),
                ),
                ListTile(
                  title: Text('Home'),
                  onTap: () {
                    // Update the state of the app
                  },
                ),
                ListTile(
                  title: Text('Saved Data Results'),
                  onTap: () {
                    // Update the state of the app
                  },
                ),
                ListTile(
                  title: Text('Shortlisted Properties'),
                  onTap: () {
                    // Update the state of the app
                  },
                ),
                ListTile(
                  title: Text('Inspection Calendar'),
                  onTap: () {
                    // Update the state of the app
                  },
                ),
                ListTile(
                  title: Text('Exit'),
                  onTap: () {
                    // Update the state of the app
                  },
                ),
              ],
            ),
          ),
          appBar: AppBar(
            title: Text(appTitle),
          ),
          body: DataResultsForm()),
    );
  }
}

// Create the MainTitleForm widget
class DataResultsForm extends StatefulWidget {
  @override
  DataResultsFormState createState() {
    return DataResultsFormState();
  }
}

// Create the MainTitleFormState class
class DataResultsFormState extends State<DataResultsForm> {
  // Show progress indicator flag
  bool _isLoading = false;

  // Override the dispose function to clean up the text controller
  // when the widget is disposed

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above
    return LoadingOverlay(
      child: Form(
        child: Container(
          width: 250.0,
          height: 860.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("test"),
            ],
          ),
        ),
      ),
      isLoading: _isLoading,
      opacity: 0.5,
      progressIndicator: CircularProgressIndicator(),
    );
  }
}
