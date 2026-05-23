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

  final String province;
  final String district;
  final String ward;
  final String address;

  final bool isIndoor;
  final bool isOpen24h;
  final bool hasAvailableSlot;
  final int availableSlots;
  final int priceValue;
  final double? distanceInMeters;

  const RentalLocation({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.type,
    required this.distanceText,
    required this.statusText,
    required this.priceText,
    required this.province,
    required this.district,
    required this.ward,
    required this.address,
    this.isIndoor = false,
    this.isOpen24h = false,
    this.hasAvailableSlot = true,
    this.availableSlots = 0,
    this.priceValue = 0,
    this.distanceInMeters,
  });

  String get fullLocationText => '$ward, $district, $province';

  String get displayDistanceText {
    final distance = distanceInMeters;
    if (distance == null) {
      return distanceText;
    }

    if (distance < 1000) {
      return '${distance.round()}m';
    }

    return '${(distance / 1000).toStringAsFixed(1)}km';
  }

  bool matchesKeyword(String keyword) {
    final normalized = keyword.trim().toLowerCase();
    if (normalized.isEmpty) return true;

    return name.toLowerCase().contains(normalized) ||
        province.toLowerCase().contains(normalized) ||
        district.toLowerCase().contains(normalized) ||
        ward.toLowerCase().contains(normalized) ||
        address.toLowerCase().contains(normalized);
  }

  RentalLocation copyWith({
    String? id,
    String? name,
    double? latitude,
    double? longitude,
    MapFilterType? type,
    String? distanceText,
    String? statusText,
    String? priceText,
    String? province,
    String? district,
    String? ward,
    String? address,
    bool? isIndoor,
    bool? isOpen24h,
    bool? hasAvailableSlot,
    int? availableSlots,
    int? priceValue,
    double? distanceInMeters,
  }) {
    return RentalLocation(
      id: id ?? this.id,
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      type: type ?? this.type,
      distanceText: distanceText ?? this.distanceText,
      statusText: statusText ?? this.statusText,
      priceText: priceText ?? this.priceText,
      province: province ?? this.province,
      district: district ?? this.district,
      ward: ward ?? this.ward,
      address: address ?? this.address,
      isIndoor: isIndoor ?? this.isIndoor,
      isOpen24h: isOpen24h ?? this.isOpen24h,
      hasAvailableSlot: hasAvailableSlot ?? this.hasAvailableSlot,
      availableSlots: availableSlots ?? this.availableSlots,
      priceValue: priceValue ?? this.priceValue,
      distanceInMeters: distanceInMeters ?? this.distanceInMeters,
    );
  }
}
