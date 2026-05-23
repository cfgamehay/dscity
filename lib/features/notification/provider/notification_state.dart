import '../../../data/models/notification/app_notification.dart';

enum NotificationTab {
  all,
  unread,
}

class NotificationState {
  final bool isLoading;
  final NotificationTab activeTab;
  final List<AppNotification> allItems;
  final List<AppNotification> visibleItems;
  final String? error;

  const NotificationState({
    this.isLoading = false,
    this.activeTab = NotificationTab.all,
    this.allItems = const [],
    this.visibleItems = const [],
    this.error,
  });

  NotificationState copyWith({
    bool? isLoading,
    NotificationTab? activeTab,
    List<AppNotification>? allItems,
    List<AppNotification>? visibleItems,
    String? error,
  }) {
    return NotificationState(
      isLoading: isLoading ?? this.isLoading,
      activeTab: activeTab ?? this.activeTab,
      allItems: allItems ?? this.allItems,
      visibleItems: visibleItems ?? this.visibleItems,
      error: error,
    );
  }
}
