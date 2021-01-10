import 'package:domain_insights_application/DomainAuthenticator.dart';
import 'package:domain_insights_application/DomainSuburbData.dart';
import 'package:domain_insights_application/DataResultsForm.dart';
import 'package:domain_insights_application/NavigationDrawer.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:loading_overlay/loading_overlay.dart';

class MainTitleFormStateless extends StatelessWidget {
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
          body: MainTitleForm()),
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

  // Create a text controller for the suburb text field
  final suburbTextController = TextEditingController();

  // Set the initial selection for the stateDropDownBox
  String stateDropDownValue = 'NSW';

  // Initialise DomainAuthenticator class
  DomainAuthenticator dc = DomainAuthenticator();

  // Authenticated flag
  bool authenticated = false;

  // API scope for authentication
  final String apiScope = 'api_addresslocators_read api_suburbperformance_read';

  // Show progress indicator flag
  bool _isLoading = false;

  // Override the initState method to load the clientId and clientSecret
  // from json only once on load
  @override
  void initState() {
    getAppInfoSecretJson().then((value) {
      setState(() {
        dc = value;
        authenticate(dc, apiScope);
      });
    });

    super.initState();
  }

  // Override the dispose function to clean up the text controller
  // when the widget is disposed
  @override
  void dispose() {
    suburbTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above
    return LoadingOverlay(
      child: Form(
        key: _formKey,
        child: Container(
          width: 250.0,
          height: 860.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              TextFormField(
                controller: suburbTextController,
                decoration: InputDecoration(
                  hintText: 'Enter a suburb or postcode',
                  border: OutlineInputBorder(),
                ),
              ),
              DropdownButton<String>(
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
                items: <String>[
                  'NSW',
                  'QLD',
                  'SA',
                  'VIC',
                  'WA',
                  'NT',
                  'TAS',
                  'ACT'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  onPressed: () async {
                    if (suburbTextController.text.isEmpty) {
                      _showErrorDialog(
                          'Suburb Field Empty!',
                          'The suburb field is empty',
                          'Please enter a suburb',
                          'OK');
                    } else {
                      showOverlay();
                      // Get the suburb ID from the supplied Suburb and State
                      int suburbID = await getDomainSuburbIdJson(
                          dc, suburbTextController.text, stateDropDownValue);

                      // Get the median sold price from the suburb ID
                      int medianSoldPrice = await getMedianSoldPriceJson(
                          dc, suburbID, stateDropDownValue);

                      // Create a DomainSuburbData object
                      DomainSuburbData dsd = DomainSuburbData(
                          suburb: suburbTextController.text,
                          suburbState: stateDropDownValue,
                          domainSid: suburbID,
                          noOfAvailableProperties: 100,
                          medianSoldPrice: medianSoldPrice);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DataResultsFormStateless(dsd: dsd)),
                      );
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
      isLoading: _isLoading,
      opacity: 0.5,
      progressIndicator: CircularProgressIndicator(),
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
  void authenticate(DomainAuthenticator dc, String apiScope) async {
    final http.Response response = await http.post(
        'https://auth.domain.com.au/v1/connect/token',
        body: <String, String>{
          'client_id': dc.clientId,
          'client_secret': dc.clientSecret,
          'grant_type': 'client_credentials',
          'scope': apiScope,
          'Content-Type': 'text/json',
        });
    if (response.statusCode == 200) {
      dc.accessToken = json.decode(response.body)['access_token'];
      authenticated = true;
    } else {
      _showErrorDialog(
          'API authentication failed!',
          'API authentication failed with the server',
          'Please restart application',
          'OK');
      throw Exception('Failed to authenticate with server!');
    }
  }

  // Function to get the domainSuburbId based on the suburb
  // entered in the text field
  Future<int> getDomainSuburbIdJson(
      DomainAuthenticator dc, String suburb, String state) async {
    final http.Response response = await http.get(
        'https://api.domain.com.au/v1/addresslocators?searchLevel=Suburb&suburb=' +
            suburb +
            "&state=" +
            state,
        headers: <String, String>{
          'Authorization': 'Bearer ' + dc.accessToken,
        });
    if (response.statusCode == 200) {
      return json.decode(response.body)[0]['ids'][0]['id'];
    } else {
      _showErrorDialog(
          'API Call Failed',
          'The suburb/state combination provided does not exist!',
          'Please enter a correct suburb/state combination',
          'OK');
      throw Exception('Failed to get suburb id from server!');
    }
  }

  // Function to get the median sold price for a given suburb ID
  Future<int> getMedianSoldPriceJson(
      DomainAuthenticator dc, int suburbID, String state) async {
    final http.Response response = await http.get(
        'https://api.domain.com.au/v1/suburbPerformanceStatistics?state=' +
            state +
            '&suburbId=' +
            suburbID.toString() +
            '&propertyCategory=house&chronologicalSpan=3&tPlusFrom=1&tPlusTo=1',
        headers: <String, String>{
          'Authorization': 'Bearer ' + dc.accessToken,
        });
    if (response.statusCode == 200) {
      return json.decode(response.body)['series']['seriesInfo'][0]['values']
          ['medianSoldPrice'];
    } else {
      _showErrorDialog('API Call Failed', 'Failed to get data from the server!',
          'Please try again', 'OK');
      throw Exception('Failed to get performance data from server!');
    }
  }

  // Alert dialog if API call fails
  Future<void> _showErrorDialog(
      String title, String message, String question, String buttonText) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
                Text(question),
              ],
            ),
          ),
          actions: <Widget>[
            RaisedButton(
              child: Text(buttonText),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Function to show a loading indicator
  void showOverlay() {
    setState(() {
      _isLoading = true;
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }
}
