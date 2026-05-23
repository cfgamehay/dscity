class ParkingItem {
  final String id;
  final String name;
  final String distanceText;
  final String statusText;
  final String priceText;
  final double latitude;
  final double longitude;

  const ParkingItem({
    required this.id,
    required this.name,
    required this.distanceText,
    required this.statusText,
    required this.priceText,
    required this.latitude,
    required this.longitude,
  });
}