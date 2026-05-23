import 'parking_feature.dart';

class ParkingDetail {
  final String id;
  final String title;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final String distanceLabel;

  final String parkingTypeLabel;
  final String securityLabel;
  final String elevatorLabel;

  final String openingHours;
  final int pricePerHour;
  final int pricePerDay;
  final String availableSlots;
  final List<String> paymentMethods;
  final List<ParkingFeature> features;

  const ParkingDetail({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.distanceLabel,
    required this.parkingTypeLabel,
    required this.securityLabel,
    required this.elevatorLabel,
    required this.openingHours,
    required this.pricePerHour,
    required this.pricePerDay,
    required this.availableSlots,
    required this.paymentMethods,
    required this.features,
  });
}