import 'package:domain_insights_application/presentation/custom_icons_icons.dart';
import 'package:flutter/material.dart';

class PropertyListingCard extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      height: 220,
      width: double.maxFinite,
      child: Card(
          elevation: 5,
          child: Padding(
              padding: EdgeInsets.all(7),
              child: Stack(
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerRight,
                      child: Stack(
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(left: 10, top: 5),
                              child: Column(
                                children: <Widget>[
                                  Row(children: <Widget>[
                                    Spacer(),
                                    bedrooms(),
                                    bedroomIcon(),
                                    bathrooms(),
                                    bathroomIcon(),
                                    carSpaces(),
                                    carIcon(),
                                  ]),
                                  Spacer(),
                                  Row(children: <Widget>[
                                    Spacer(),
                                    price(),
                                  ])
                                ],
                              ))
                        ],
                      ))
                ],
              ))),
    );
  }

  Widget carIcon() {
    return Align(
      alignment: Alignment.topRight,
      child: Icon(
        Icons.directions_car,
        color: Colors.green,
        size: 30,
      ),
    );
  }

  Widget bathroomIcon() {
    return Align(
      alignment: Alignment.topRight,
      child: Icon(
        CustomIcons.bath,
        color: Colors.green,
        size: 30,
      ),
    );
  }

  Widget bedroomIcon() {
    return Align(
      alignment: Alignment.topRight,
      child: Icon(
        Icons.hotel,
        color: Colors.green,
        size: 30,
      ),
    );
  }

  Widget carSpaces() {
    return Align(
      alignment: Alignment.topRight,
      child: RichText(
        text: TextSpan(
          text: '2',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.green, fontSize: 20),
        ),
      ),
    );
  }

  Widget bathrooms() {
    return Align(
      alignment: Alignment.topRight,
      child: RichText(
        text: TextSpan(
          text: '1',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.green, fontSize: 20),
        ),
      ),
    );
  }

  Widget bedrooms() {
    return Align(
      alignment: Alignment.topRight,
      child: RichText(
        text: TextSpan(
          text: '2',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.green, fontSize: 20),
        ),
      ),
    );
  }

  Widget price() {
    return Align(
        alignment: Alignment.centerRight,
        child: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: RichText(
                textAlign: TextAlign.right,
                text: TextSpan(
                    text: "\$799,000",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 35,
                    )))));
  }
}
