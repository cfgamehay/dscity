import '../../models/notification/app_notification.dart';

abstract class NotificationRepository {
  Future<List<AppNotification>> getNotifications();
}
