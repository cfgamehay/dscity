import '../../../core/constants/enum.dart';

class RentalLocation {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final MapFilterType type;
  final String distanceText;
  final String statusText;
  final String priceText;

  const RentalLocation({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.type,
    required this.distanceText,
    required this.statusText,
    required this.priceText,
  });
}
