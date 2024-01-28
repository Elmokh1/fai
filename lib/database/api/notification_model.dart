class NotificationData {
  late String to;
  late Notification notification;
  late Map<String, dynamic> data;

  NotificationData({
    required this.to,
    required this.notification,
    required this.data,
  });

  Map<String, dynamic> toJson() {
    return {
      "to": to,
      "notification": notification.toJson(),
      "data": data,
    };
  }
}

class Notification {
  late String title;
  late String body;
  late String priority;
  late String androidChannelId;

  Notification({
    required this.title,
    required this.body,
    required this.priority,
    required this.androidChannelId,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "body": body,
      "priority": priority,
      "android_channel_id": androidChannelId,
    };
  }
}