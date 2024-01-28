import 'dart:convert';
import 'package:http/http.dart' as http;

import 'notification_model.dart';

class NotificationApi {
  Future<void> sendNotification(NotificationData notificationData) async {
    final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
    final headers = {
      'Authorization':
          'key=AAAA4twdgXo:APA91bHoj5UspPZ6Hb8JbPTt4OWWmOS6iovqca59SH9A1wZEd26RTOe0oC420PnyJxfnRG7x-Chsx3Y1a1o5ka2vwD90eK6Rliy7v4TKBDl7QvzrPIInmmy0zXQoIDCo0s1X8x-Q2yAl',
      'Content-Type': 'application/json',
    };

    final body = json.encode(notificationData.toJson());

    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      // تم إرسال الإشعار بنجاح
      print('تم إرسال الإشعار بنجاح!');
    } else {
      // حدث خطأ أثناء إرسال الإشعار
      print('حدث خطأ أثناء إرسال الإشعار');
      print('StatusCode: ${response.statusCode}');
      print('Body: ${response.body}');
    }
  }
}
