enum AppNotificationType {
  booking,
  system,
  sharing,
  promotion,
}

class AppNotification {
  final String id;
  final AppNotificationType type;
  final String title;
  final String message;
  final String timeLabel;
  final bool isRead;

  const AppNotification({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.timeLabel,
    this.isRead = false,
  });

  AppNotification copyWith({
    String? id,
    AppNotificationType? type,
    String? title,
    String? message,
    String? timeLabel,
    bool? isRead,
  }) {
    return AppNotification(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      message: message ?? this.message,
      timeLabel: timeLabel ?? this.timeLabel,
      isRead: isRead ?? this.isRead,
    );
  }
}
