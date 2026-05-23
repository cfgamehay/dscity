class ShareTrip {
  final String id;
  final String driverName;
  final double rating;
  final String fromLabel;
  final String toLabel;
  final String departureLabel;
  final int pricePerSeat;
  final int availableSeats;
  final String pickupId;
  final String dropoffId;

  const ShareTrip({
    required this.id,
    required this.driverName,
    required this.rating,
    required this.fromLabel,
    required this.toLabel,
    required this.departureLabel,
    required this.pricePerSeat,
    required this.availableSeats,
    required this.pickupId,
    required this.dropoffId,
  });
}
