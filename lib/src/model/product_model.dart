import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AgentProperty {
  final String propertyName;
  final String propertyType;
  final String propertyLocation;
  final double propertyPrice;
  final List<String> propertyImages;
  final String propertyDescription;
  final String propertyId;
  final String propertyOwnerId;
  final String propertyOwnerName;
  final int? numberOfRooms;
  final int? numberOfBathrooms;
  final int meters;
  final DateTime createdAt;
  final String agentProfileImage;

  AgentProperty({
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
    required this.meters,
    required this.createdAt,
    required this.agentProfileImage,
  });

  AgentProperty copyWith({
    String? propertyName,
    String? propertyType,
    String? propertyLocation,
    double? propertyPrice,
    List<String>? propertyImages,
    String? propertyDescription,
    String? propertyId,
    String? propertyOwnerId,
    String? propertyOwnerName,
    int? numberOfRooms,
    int? numberOfBathrooms,
    int? meters,
    DateTime? createdAt,
    String? agentProfileImage,
  }) {
    return AgentProperty(
      propertyName: propertyName ?? this.propertyName,
      propertyType: propertyType ?? this.propertyType,
      propertyLocation: propertyLocation ?? this.propertyLocation,
      propertyPrice: propertyPrice ?? this.propertyPrice,
      propertyImages: propertyImages ?? this.propertyImages,
      propertyDescription: propertyDescription ?? this.propertyDescription,
      propertyId: propertyId ?? this.propertyId,
      propertyOwnerId: propertyOwnerId ?? this.propertyOwnerId,
      propertyOwnerName: propertyOwnerName ?? this.propertyOwnerName,
      numberOfRooms: numberOfRooms ?? this.numberOfRooms,
      numberOfBathrooms: numberOfBathrooms ?? this.numberOfBathrooms,
      meters: meters ?? this.meters,
      createdAt: createdAt ?? this.createdAt,
      agentProfileImage: agentProfileImage ?? this.agentProfileImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'propertyName': propertyName,
      'propertyType': propertyType,
      'propertyLocation': propertyLocation,
      'propertyPrice': propertyPrice,
      'propertyImages': propertyImages,
      'propertyDescription': propertyDescription,
      'propertyId': propertyId,
      'propertyOwnerId': propertyOwnerId,
      'propertyOwnerName': propertyOwnerName,
      'numberOfRooms': numberOfRooms,
      'numberOfBathrooms': numberOfBathrooms,
      'meters': meters,
      'createdAt': createdAt,
      'agentProfileImage': agentProfileImage,
    };
  }

  factory AgentProperty.fromMap(Map<String, dynamic> map) {
    return AgentProperty(
      propertyName: map['propertyName'] as String,
      propertyType: map['propertyType'] as String,
      propertyLocation: map['propertyLocation'] as String,
      propertyPrice: map['propertyPrice'] as double,
      propertyImages:
          List<String>.from((map['propertyImages'] as List<dynamic>)),
      propertyDescription: map['propertyDescription'] as String,
      propertyId: map['propertyId'] as String,
      propertyOwnerId: map['propertyOwnerId'] as String,
      propertyOwnerName: map['propertyOwnerName'] as String,
      numberOfRooms: map['numberOfRooms'] as int,
      numberOfBathrooms: map['numberOfBathrooms'] as int,
      meters: map['meters'] as int,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      agentProfileImage: map['agentProfileImage'] as String,
    );
  }

  @override
  String toString() {
    return 'AgentProperty(propertyName: $propertyName, propertyType: $propertyType, propertyLocation: $propertyLocation, propertyPrice: $propertyPrice, propertyImages: $propertyImages, propertyDescription: $propertyDescription, propertyId: $propertyId, propertyOwnerId: $propertyOwnerId, propertyOwnerName: $propertyOwnerName, numberOfRooms: $numberOfRooms, numberOfBathrooms: $numberOfBathrooms, meters: $meters)';
  }

  @override
  bool operator ==(covariant AgentProperty other) {
    if (identical(this, other)) return true;

    return other.propertyName == propertyName &&
        other.propertyType == propertyType &&
        other.propertyLocation == propertyLocation &&
        other.propertyPrice == propertyPrice &&
        listEquals(other.propertyImages, propertyImages) &&
        other.propertyDescription == propertyDescription &&
        other.propertyId == propertyId &&
        other.propertyOwnerId == propertyOwnerId &&
        other.propertyOwnerName == propertyOwnerName &&
        other.numberOfRooms == numberOfRooms &&
        other.numberOfBathrooms == numberOfBathrooms &&
        other.meters == meters;
  }

  @override
  int get hashCode {
    return propertyName.hashCode ^
        propertyType.hashCode ^
        propertyLocation.hashCode ^
        propertyPrice.hashCode ^
        propertyImages.hashCode ^
        propertyDescription.hashCode ^
        propertyId.hashCode ^
        propertyOwnerId.hashCode ^
        propertyOwnerName.hashCode ^
        numberOfRooms.hashCode ^
        numberOfBathrooms.hashCode ^
        meters.hashCode;
  }
}
