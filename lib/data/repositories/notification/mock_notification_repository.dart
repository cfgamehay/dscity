import '../../models/notification/app_notification.dart';
import 'notification_repository.dart';

class MockNotificationRepository implements NotificationRepository {
  @override
  Future<List<AppNotification>> getNotifications() async {
    await Future<void>.delayed(const Duration(milliseconds: 180));

    return const [
      AppNotification(
        id: 'noti_1',
        type: AppNotificationType.booking,
        title: 'Đặt chỗ đã được xác nhận',
        message:
            'Bãi đậu xe Central Hub đã xác nhận chỗ của bạn cho hôm nay từ 09:00 đến 18:00.',
        timeLabel: '5 phút trước',
      ),
      AppNotification(
        id: 'noti_2',
        type: AppNotificationType.sharing,
        title: 'Tài xế đã nhắn cho bạn',
        message:
            'Tài xế Minh Đức đã cập nhật điểm đón tại cổng chính KTX khu A.',
        timeLabel: '20 phút trước',
      ),
      AppNotification(
        id: 'noti_3',
        type: AppNotificationType.system,
        title: 'Cập nhật điều khoản dịch vụ',
        message:
            'Chúng tôi đã cập nhật điều khoản sử dụng cho dịch vụ thuê xe và đặt chỗ.',
        timeLabel: 'Hôm nay, 08:00',
        isRead: true,
      ),
      AppNotification(
        id: 'noti_4',
        type: AppNotificationType.promotion,
        title: 'Ưu đãi cuối tuần',
        message:
            'Giảm 15% cho các đơn thuê xe máy trong cuối tuần này tại khu vực Thủ Đức.',
        timeLabel: 'Hôm qua',
        isRead: true,
      ),
    ];
  }
}
