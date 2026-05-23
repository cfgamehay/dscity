import 'share_rule.dart';
import 'share_stop_point.dart';

class ShareDetail {
  final String id;
  final String routeTitle;
  final String departureTime;
  final String durationLabel;
  final int pricePerSeat;
  final int availableSeats;

  final String driverName;
  final double driverRating;
  final int completedTrips;
  final String vehicleName;
  final String vehiclePlate;
  final String vehicleColor;

  final List<ShareStopPoint> stopPoints;
  final List<ShareRule> rules;

  final String note;
  final String buttonText;

  const ShareDetail({
    required this.id,
    required this.routeTitle,
    required this.departureTime,
    required this.durationLabel,
    required this.pricePerSeat,
    required this.availableSeats,
    required this.driverName,
    required this.driverRating,
    required this.completedTrips,
    required this.vehicleName,
    required this.vehiclePlate,
    required this.vehicleColor,
    required this.stopPoints,
    required this.rules,
    required this.note,
    required this.buttonText,
  });
}