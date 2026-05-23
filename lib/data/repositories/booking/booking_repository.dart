import '../../models/booking/booking_history_item.dart';

abstract class BookingRepository {
  Future<List<BookingHistoryItem>> getBookings();
}
