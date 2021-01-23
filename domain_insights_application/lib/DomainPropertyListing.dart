class DomainPropertyListing {
  // Attributes
  String listingTitle;
  String listingDescription;
  String listingPropertyType;
  String listingAddress;
  String listingNextInspection;
  String listingPrice;
  double listingBedrooms;
  double listingBathrooms;
  int listingCarSpaces;

  // Constructor
  DomainPropertyListing(
      {this.listingTitle,
      this.listingDescription,
      this.listingPropertyType,
      this.listingAddress,
      this.listingNextInspection,
      this.listingPrice,
      this.listingBedrooms,
      this.listingBathrooms,
      this.listingCarSpaces});

  // Methods
  DomainPropertyListing.fromJson(Map<String, dynamic> jsonToken) {
    listingTitle = jsonToken['listing']['headline'];
    listingDescription = jsonToken['listing']['summaryDescription'];
    listingPropertyType =
        jsonToken['listing']['propertyDetails']['propertyType'];
    listingAddress =
        jsonToken['listing']['propertyDetails']['displayableAddress'];
    listingNextInspection =
        jsonToken['listing']['propertyDetails']['propertyType'];
    listingPrice = jsonToken['listing']['priceDetails']['displayPrice'];
    listingBedrooms = jsonToken['listing']['propertyDetails']['bedrooms'];
    listingBathrooms = jsonToken['listing']['propertyDetails']['bathrooms'];
    listingCarSpaces = jsonToken['listing']['propertyDetails']['carspaces'];
  }
}
