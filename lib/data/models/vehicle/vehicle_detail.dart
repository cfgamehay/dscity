import 'vehicle_feature.dart';

class VehicleDetail {
  final String id;
  final String title;
  final String imageUrl;
  final String transmissionLabel;
  final String specLabel;
  final String fuelLabel;
  final double rating;
  final int reviewCount;
  final String basePriceLabel;
  final String pricePerHour;
  final String pricePerDay;
  final String pricePerWeek;
  final List<VehicleFeature> features;
  final String buttonText;

  const VehicleDetail({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.transmissionLabel,
    required this.specLabel,
    required this.fuelLabel,
    required this.rating,
    required this.reviewCount,
    required this.basePriceLabel,
    required this.pricePerHour,
    required this.pricePerDay,
    required this.pricePerWeek,
    required this.features,
    required this.buttonText,
  });
}