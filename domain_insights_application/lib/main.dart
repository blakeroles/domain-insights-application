import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        body: MainTitleForm(),
      ),
    );
  }
}

// Create the MainTitleForm widget
class MainTitleForm extends StatefulWidget {
  @override
  MainTitleFormState createState() {
    return MainTitleFormState();
  }
}

// Create the MainTitleFormState class
class MainTitleFormState extends State<MainTitleForm> {
  // Create a global key that uniquely identifies the From widget
  // and allows validation of the form
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above
    return Form(
      key: _formKey,
      child: Container(
        width: 250.0,
        height: 860.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Enter a suburb or postcode',
                border: OutlineInputBorder(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Processing Data')));
                  }
                },
                child: Text('Submit'),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
