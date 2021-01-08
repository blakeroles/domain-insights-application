class DomainSuburb {
  // Attributes
  String suburbName;
  int domainSuburbID;

  // Constructor
  DomainSuburb(String suburb) {
    this.suburbName = suburb;
  }

  // Methods
  DomainSuburb.fromJson(Map<String, dynamic> jsonToken) {
    domainSuburbID = jsonToken['Suburb'];
  }
}
