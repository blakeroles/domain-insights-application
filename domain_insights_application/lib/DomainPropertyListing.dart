class DomainPropertyListing {
  // Attributes
  String listingTitle;
  String listingDescription;
  String listingPropertyType;
  String listingAddress;
  String listingNextInspection;
  int listingPrice;
  int listingBedrooms;
  int listingBathrooms;
  int listingCarSpaces;

  // Constructor
  DomainPropertyListing(
      String listingTitle,
      String listingDescription,
      String listingPropertyType,
      String listingAddress,
      String listingNextInspection,
      int listingPrice,
      int listingBedrooms,
      int listingBathrooms,
      int listingCarSpaces) {
    this.listingTitle = listingTitle;
    this.listingDescription = listingDescription;
    this.listingPropertyType = listingPropertyType;
    this.listingAddress = listingAddress;
    this.listingNextInspection = listingNextInspection;
    this.listingPrice = listingPrice;
    this.listingBedrooms = listingBedrooms;
    this.listingBathrooms = listingBathrooms;
    this.listingCarSpaces = listingCarSpaces;
  }

  // Methods

}
