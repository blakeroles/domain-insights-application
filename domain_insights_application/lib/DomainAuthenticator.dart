// This class is responsible for storing the values that are required
// for authenticate with the Domain API
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
