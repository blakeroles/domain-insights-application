import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iPropty',
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
                child: Text('Drawer Header'),
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
          title: Text("iPropty"),
        ),
        body: Center(
          child: Text("Hello world!"),
        ),
      ),
    );
  }
}
