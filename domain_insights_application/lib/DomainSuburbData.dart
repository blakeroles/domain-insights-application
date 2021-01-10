import 'package:domain_insights_application/DomainSuburb.dart';
import 'package:flutter/material.dart';

class DomainSuburbData extends DomainSuburb {
  int noOfAvailableProperties;
  int medianSoldPrice;

  DomainSuburbData(
      {@required String suburb,
      @required String suburbState,
      @required domainSid,
      @required this.noOfAvailableProperties,
      @required this.medianSoldPrice})
      : super(suburb: suburb, suburbState: suburbState, domainSid: domainSid);
}
