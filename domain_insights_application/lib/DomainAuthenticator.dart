import 'package:flutter/material.dart';

class DomainAuthenticator {
  // Attributes
  String clientId;
  String clientSecret;

  // Constructors
  DomainAuthenticator({this.clientId, this.clientSecret});

  // Methods
  DomainAuthenticator.fromJson(Map<String, dynamic> jsonToken) {
    clientId = jsonToken['client_id'];
    clientSecret = jsonToken['client_secret'];
  }
}
