import '../../../data/models/booking/booking_history_item.dart';

enum BookingTab {
  active,
  history,
  saved,
}

class BookingState {
  final bool isLoading;
  final BookingTab activeTab;
  final List<BookingHistoryItem> allItems;
  final List<BookingHistoryItem> visibleItems;
  final String? error;

  const BookingState({
    this.isLoading = false,
    this.activeTab = BookingTab.active,
    this.allItems = const [],
    this.visibleItems = const [],
    this.error,
  });

  BookingState copyWith({
    bool? isLoading,
    BookingTab? activeTab,
    List<BookingHistoryItem>? allItems,
    List<BookingHistoryItem>? visibleItems,
    String? error,
  }) {
    return BookingState(
      isLoading: isLoading ?? this.isLoading,
      activeTab: activeTab ?? this.activeTab,
      allItems: allItems ?? this.allItems,
      visibleItems: visibleItems ?? this.visibleItems,
      error: error,
    );
  }
}
