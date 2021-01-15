import 'package:domain_insights_application/DomainPropertyListing.dart';
import 'package:domain_insights_application/DomainSuburbData.dart';
import 'package:domain_insights_application/NavigationDrawer.dart';
import 'package:domain_insights_application/PropertyListingCard.dart';
import 'package:flutter/material.dart';

class DataResultsFormStateless extends StatelessWidget {
  // Declare a field to store the sent DomainSuburb data
  final DomainSuburbData dsd;

  DataResultsFormStateless({Key key, @required this.dsd}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final appTitle = 'iPropty';

    DomainPropertyListing dPL = DomainPropertyListing(
        "Auction - Contact Agent",
        "Delightful townhouse",
        "Townhouse",
        "30/19 Taranto Road, Marsfield, NSW 2122",
        "Saturday 16th January 2021 12pm",
        800000,
        2,
        1,
        1);

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
              child: Column(children: <Widget>[
                Table(children: [
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
                    TableCell(
                        child: Text(dsd.noOfAvailableProperties.toString()))
                  ]),
                  TableRow(children: [
                    TableCell(child: Text('Median sold price')),
                    TableCell(child: Text(dsd.medianSoldPrice.toString()))
                  ])
                ]),
                PropertyListingCard(dPL),
              ])),
        ));
  }
}
