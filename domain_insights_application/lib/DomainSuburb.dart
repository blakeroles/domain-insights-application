import 'package:flutter/material.dart';

class DomainSuburb {
  // Attributes
  String suburbName;
  String suburbState;
  int domainSuburbID;

  // Constructor
  DomainSuburb(
      {@required String suburb,
      @required String suburbState,
      @required int domainSid}) {
    this.suburbName = suburb;
    this.suburbState = suburbState;
    this.domainSuburbID = domainSid;
  }
}
