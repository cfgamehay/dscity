enum BookingType {
  parking,
  vehicle,
  sharing,
}

enum BookingStatus {
  pending,
  confirmed,
  completed,
  canceled,
  saved,
}

class BookingHistoryItem {
  final String id;
  final BookingType type;
  final BookingStatus status;
  final String title;
  final String subtitle;
  final String timeLabel;
  final String locationLabel;
  final int totalPrice;
  final String priceLabel;
  final String statusLabel;
  final String actionLabel;
  final String note;

  const BookingHistoryItem({
    required this.id,
    required this.type,
    required this.status,
    required this.title,
    required this.subtitle,
    required this.timeLabel,
    required this.locationLabel,
    required this.totalPrice,
    required this.priceLabel,
    required this.statusLabel,
    required this.actionLabel,
    required this.note,
  });
}
