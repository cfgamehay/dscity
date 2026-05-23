import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/notification/app_notification.dart';
import '../../../data/repositories/notification/mock_notification_repository.dart';
import '../../../data/repositories/notification/notification_repository.dart';
import 'notification_state.dart';

final notificationProvider =
    NotifierProvider<NotificationProvider, NotificationState>(
  NotificationProvider.new,
);

class NotificationProvider extends Notifier<NotificationState> {
  late final NotificationRepository _repository;

  @override
  NotificationState build() {
    _repository = MockNotificationRepository();
    return const NotificationState();
  }

  Future<void> firstLoad() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final items = await _repository.getNotifications();
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

  void changeTab(NotificationTab tab) {
    state = state.copyWith(activeTab: tab);
    _applyTab();
  }

  void markAsRead(String id) {
    final nextItems = state.allItems.map((item) {
      if (item.id != id || item.isRead) return item;
      return item.copyWith(isRead: true);
    }).toList();

    state = state.copyWith(allItems: nextItems);
    _applyTab();
  }

  void markAllAsRead() {
    final nextItems = state.allItems.map((item) {
      return item.isRead ? item : item.copyWith(isRead: true);
    }).toList();

    state = state.copyWith(allItems: nextItems);
    _applyTab();
  }

  void _applyTab() {
    final items = state.activeTab == NotificationTab.all
        ? state.allItems
        : state.allItems.where((item) => !item.isRead).toList();

    state = state.copyWith(visibleItems: items);
  }
}
