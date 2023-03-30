class AgentProperty1 {
  final String propertyName;
  final String propertyType;
  final String propertyLocation;
  final double propertyPrice;
  final List<String> propertyImages;
  final String propertyDescription;
  final String propertyId;
  final String propertyOwnerId;
  final String propertyOwnerName;
  final int numberOfRooms;
  final int numberOfBathrooms;
  final int meters;

  AgentProperty1({
    required this.meters,
    required this.propertyName,
    required this.propertyType,
    required this.propertyLocation,
    required this.propertyPrice,
    required this.propertyImages,
    required this.propertyDescription,
    required this.propertyId,
    required this.propertyOwnerId,
    required this.propertyOwnerName,
    required this.numberOfRooms,
    required this.numberOfBathrooms,
  });
}

List<AgentProperty1> properties = [
  AgentProperty1(
    meters: 500,
    propertyName: 'Bluish House',
    propertyType: 'House',
    propertyLocation: '12, Ogunlana Drive, Surulere, Lagos',
    propertyPrice: 2000000,
    propertyImages: [
      'assets/images/images1.jpg',
      'assets/images/images2.jpg',
      'assets/images/images3.jpg',
      'assets/images/images4.jpg',
    ],
    propertyDescription: 'This is a very nice house with a very nice view',
    propertyId: '1',
    propertyOwnerId: '1',
    propertyOwnerName: 'John Doe',
    numberOfRooms: 3,
    numberOfBathrooms: 4,
  ),
  AgentProperty1(
    meters: 700,
    propertyName: 'Bonny Home',
    propertyType: 'House',
    propertyLocation: '12, adeku Drive, badiga, Lagos',
    propertyPrice: 15000000,
    propertyImages: [
      'assets/images/images3.jpg',
      'assets/images/images4.jpg',
      'assets/images/images1.jpg',
      'assets/images/images2.jpg',
    ],
    propertyDescription: 'This is a very nice house with a very nice view'
        'This is a very nice house with a very nice view'
        'This is a very nice house with a very nice view',
    propertyId: '1',
    propertyOwnerId: '1',
    propertyOwnerName: 'Peter Doe',
    numberOfRooms: 6,
    numberOfBathrooms: 7,
  ),
  AgentProperty1(
    meters: 570,
    propertyName: 'Green pack',
    propertyType: 'House',
    propertyLocation: '12, Safari Garden, Ajah , Lagos',
    propertyPrice: 23580000,
    propertyImages: [
      'assets/images/images2.jpg',
      'assets/images/images3.jpg',
      'assets/images/images4.jpg',
      'assets/images/images1.jpg',
      'assets/images/images2.jpg',
    ],
    propertyDescription: 'This is a very nice house with a very nice view',
    propertyId: '1',
    propertyOwnerId: '1',
    propertyOwnerName: 'Peter Doe',
    numberOfRooms: 5,
    numberOfBathrooms: 3,
  ),
];
