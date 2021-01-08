import 'package:domain_insights_application/DomainAuthenticator.dart';
import 'package:domain_insights_application/DomainSuburb.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;

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

  // Initialise DomainAuthenticator class
  DomainAuthenticator dc = DomainAuthenticator();

  // Override the initState method to load the clientId and clientSecret
  // from json only once on load
  @override
  void initState() {
    getAppInfoSecretJson().then((value) {
      setState(() {
        dc = value;
        authenticate(dc);
      });
    });

    super.initState();
  }

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
                  var ds = DomainSuburb("Kellyville");
                  getDomainSuburbIdJson(dc, ds);
                  print(ds.domainSuburbID);
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

  // Function to load the app_info.secret json file and create a
  // DomainAuthenticator object
  Future<DomainAuthenticator> getAppInfoSecretJson() async {
    var appInfoSecretJson =
        json.decode(await rootBundle.loadString('assets/app_info.secret'));
    DomainAuthenticator dc =
        DomainAuthenticator.fromJson(appInfoSecretJson['api_info']);
    return dc;
  }

  // Function to authenticate with the domain server and
  // retrieve an access code to use
  void authenticate(DomainAuthenticator dc) async {
    final http.Response response = await http.post(
        'https://auth.domain.com.au/v1/connect/token',
        body: <String, String>{
          'client_id': dc.clientId,
          'client_secret': dc.clientSecret,
          'grant_type': 'client_credentials',
          'scope': 'api_addresslocators_read',
          'Content-Type': 'text/json',
        });
    if (response.statusCode == 200) {
      dc.accessToken = json.decode(response.body)['access_token'];
    } else {
      throw Exception('Failed to authenticate with server!');
    }
  }

  // Function to get the domainSuburbId based on the suburb
  // entered in the text field
  void getDomainSuburbIdJson(DomainAuthenticator dc, DomainSuburb ds) async {
    final http.Response response = await http.get(
        'https://api.domain.com.au/v1/addresslocators?searchLevel=Suburb&suburb=' +
            ds.suburbName +
            "&state=NSW",
        headers: <String, String>{
          'Authorization': 'Bearer ' + dc.accessToken,
        });
    if (response.statusCode == 200) {
      ds.domainSuburbID = json.decode(response.body)[0]['ids'][0]['id'];
    } else {
      throw Exception('Failed to get suburb id from server!');
    }
  }
}
