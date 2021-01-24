import 'package:domain_insights_application/DomainAuthenticator.dart';
import 'package:domain_insights_application/DomainPropertyListing.dart';
import 'package:domain_insights_application/DomainSuburbData.dart';
import 'package:domain_insights_application/DataResultsForm.dart';
import 'package:domain_insights_application/NavigationDrawer.dart';
import 'package:domain_insights_application/CustomDropDownButton.dart';
import 'package:domain_insights_application/presentation/custom_icons_icons.dart';
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

  // Initialise the DropDownButtons
  CustomDropDownButton sDDB = CustomDropDownButton(
      'NSW', ['NSW', 'QLD', 'SA', 'VIC', 'WA', 'NT', 'TAS', 'ACT']);
  CustomDropDownButton nDDBBed =
      CustomDropDownButton("1", ['1', '2', '3', '4', '5']);
  CustomDropDownButton nDDBBath =
      CustomDropDownButton("1", ['1', '2', '3', '4', '5']);
  CustomDropDownButton nDDBCar =
      CustomDropDownButton("1", ['1', '2', '3', '4', '5']);
  CustomDropDownButton pDDB = CustomDropDownButton(
      'House', ['House', 'Townhouse', 'ApartmentUnitFlat']);

  // Initialise DomainAuthenticator class
  DomainAuthenticator dc = DomainAuthenticator();

  // Authenticated flag
  bool authenticated = false;

  // API scope for authentication
  final String apiScope =
      'api_addresslocators_read api_suburbperformance_read api_listings_read';

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
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Table(children: [
                TableRow(children: [
                  TableCell(child: Text('Suburb')),
                  TableCell(
                    child: TextFormField(
                      controller: suburbTextController,
                      decoration: InputDecoration(
                        hintText: 'Enter a suburb',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  )
                ]),
                TableRow(children: [
                  TableCell(child: Text('State')),
                  TableCell(
                    child: sDDB,
                  ),
                ]),
                TableRow(children: [
                  TableCell(child: Text('Property Type')),
                  TableCell(
                    child: pDDB,
                  ),
                ]),
                TableRow(children: [
                  TableCell(
                    child: Icon(Icons.hotel),
                  ),
                  TableCell(child: nDDBBed),
                ]),
                TableRow(children: [
                  TableCell(
                    child: Icon(CustomIcons.bath),
                  ),
                  TableCell(child: nDDBBath),
                ]),
                TableRow(children: [
                  TableCell(
                    child: Icon(Icons.directions_car),
                  ),
                  TableCell(child: nDDBCar),
                ]),
              ]),
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
                          dc, suburbTextController.text, sDDB.dropDownValue);

                      // Get the median sold price from the suburb ID
                      int medianSoldPrice = await getMedianSoldPriceJson(
                          dc, suburbID, sDDB.dropDownValue);

                      // Create a DomainSuburbData object
                      DomainSuburbData dsd = DomainSuburbData(
                          suburb: suburbTextController.text,
                          suburbState: sDDB.dropDownValue,
                          domainSid: suburbID,
                          noOfAvailableProperties: 100,
                          medianSoldPrice: medianSoldPrice);

                      // Get the Domain Listings based on data entered
                      List<DomainPropertyListing> dPLList =
                          await getSuburbListings(
                              pDDB.dropDownValue,
                              suburbTextController.text,
                              sDDB.dropDownValue,
                              nDDBBed.dropDownValue,
                              nDDBBath.dropDownValue,
                              nDDBCar.dropDownValue);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DataResultsFormStateless(
                                dsd: dsd, dPLList: dPLList)),
                      );
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
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

  // Function to get the suburb listings from Domain based on the
  // form data
  Future<List<DomainPropertyListing>> getSuburbListings(
      String propertyType,
      String suburb,
      String state,
      String bedrooms,
      String bathrooms,
      String carSpaces) async {
    // Construct a list of property types for the json post
    List<String> propertyTypes = List<String>();
    propertyTypes.add(propertyType);

    // Construct a list of locations for the json post
    List<Map> locations = List<Map>();

    Map location = {
      'state': state,
      'suburb': suburb,
      'includeSurroundingSuburbs': 'false',
    };

    locations.add(location);

    // Construct the data json Map to be sent with the post http call
    Map data = {
      'listingType': 'Sale',
      'propertyTypes': propertyTypes,
      'minBedrooms': bedrooms,
      'minBathrooms': bathrooms,
      'minCarspaces': carSpaces,
      'locations': locations,
    };

    // Encode the body of the response with json type
    var body = json.encode(data);

    // Make a call to the api and get a response
    final http.Response response = await http.post(
        'https://api.domain.com.au/v1/listings/residential/_search',
        body: body,
        headers: <String, String>{
          'Authorization': 'Bearer ' + dc.accessToken,
          'Content-Type': 'application/json',
        });

    if (response.statusCode == 200) {
      List<DomainPropertyListing> dPLList;

      dPLList = (json.decode(response.body) as List)
          .map((i) => DomainPropertyListing.fromJson(i))
          .toList();

      return dPLList;
    } else {
      _showErrorDialog('API Call Failed', 'Failed to get data from the server!',
          'Please try again', 'OK');
      throw Exception('Failed to get listing data from server!');
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
