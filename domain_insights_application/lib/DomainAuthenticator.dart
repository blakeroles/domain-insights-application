import 'package:flutter/material.dart';

class DomainAuthenticator {
  // Attributes
  final String clientId;
  final String clientSecret;

  // Constructors
  DomainAuthenticator({this.clientId, this.clientSecret});

  // Methods
  factory DomainAuthenticator.fromJson(Map<String, String> jsonToken) {
    return DomainAuthenticator(
        clientId: jsonToken['client_id'],
        clientSecret: jsonToken['client_secret']);
  }
}
