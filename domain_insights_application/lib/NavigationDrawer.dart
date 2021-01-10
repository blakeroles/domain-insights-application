import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  final appTitle = 'iPropty';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              // Update the state of the app
            },
          ),
          ListTile(
            leading: Icon(Icons.save_alt),
            title: Text('Saved Data Results'),
            onTap: () {
              // Update the state of the app
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Shortlisted Properties'),
            onTap: () {
              // Update the state of the app
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Inspection Calendar'),
            onTap: () {
              // Update the state of the app
            },
          ),
        ],
      ),
    );
  }
}
