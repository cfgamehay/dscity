import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/booking/booking_history_item.dart';
import '../../../data/repositories/booking/booking_repository.dart';
import '../../../data/repositories/booking/mock_booking_repository.dart';
import 'booking_state.dart';

final bookingProvider = NotifierProvider<BookingProvider, BookingState>(
  BookingProvider.new,
);

class BookingProvider extends Notifier<BookingState> {
  late final BookingRepository _repository;

  @override
  BookingState build() {
    _repository = MockBookingRepository();
    return const BookingState();
  }

  Future<void> firstLoad() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final items = await _repository.getBookings();
      state = state.copyWith(
        isLoading: false,
        allItems: items,
      );
      _applyTab();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void changeTab(BookingTab tab) {
    state = state.copyWith(activeTab: tab);
    _applyTab();
  }

  void _applyTab() {
    final items = state.allItems.where((item) {
      switch (state.activeTab) {
        case BookingTab.active:
          return item.status == BookingStatus.pending ||
              item.status == BookingStatus.confirmed;
        case BookingTab.history:
          return item.status == BookingStatus.completed ||
              item.status == BookingStatus.canceled;
        case BookingTab.saved:
          return item.status == BookingStatus.saved;
      }
    }).toList();

    state = state.copyWith(visibleItems: items);
  }
}
