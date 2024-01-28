// import 'dart:io';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// import 'api/api_manger.dart';
// import 'api/notification_model.dart';
//
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print("Handling a background message: ${message.messageId}");
// }
//
// class FcmHelper {
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//   AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//     description: 'This channel is used for important notifications.',
//     // description
//     importance: Importance.max,
//   );
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   Future<void> initFcmMessage() async {
//     await requestPermissionForIos();
//     await getDeviceToken();
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print('Got a message whilst in the foreground!');
//       print('Message data: ${message.data}');
//
//       if (message.notification != null) {
//         print('Message also contained a notification: ${message.notification}');
//       }
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;
//
//       // If `onMessage` is triggered with a notification, construct our own
//       // local notification to show to users using the created channel.
//       if (notification != null && android != null) {
//         flutterLocalNotificationsPlugin.show(
//             notification.hashCode,
//             notification.title,
//             notification.body,
//             NotificationDetails(
//               android: AndroidNotificationDetails(
//                 channel.id,
//                 channel.name,
//                 channelDescription: channel.description,
//                 icon: android?.smallIcon,
//                 // other properties...
//               ),
//             ));
//       }
//     });
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//     Future<void> initLocalNotification() async {
//       await FirebaseMessaging.instance
//           .setForegroundNotificationPresentationOptions(
//         alert: true, // Required to display a heads up notification
//         badge: true,
//         sound: true,
//       );
//       AndroidNotificationChannel channel = AndroidNotificationChannel(
//         'high_importance_channel', // id
//         'High Importance Notifications', // title
//         description: 'This channel is used for important notifications.',
//         // description
//         importance: Importance.max,
//       );
//       await flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<
//               AndroidFlutterLocalNotificationsPlugin>()
//           ?.createNotificationChannel(channel);
//     }
//   }
//
//   Future<void> requestPermissionForIos() async {
//     if (Platform.isIOS) {
//       NotificationSettings settings = await messaging.requestPermission(
//         alert: true,
//         announcement: false,
//         badge: true,
//         carPlay: false,
//         criticalAlert: false,
//         provisional: false,
//         sound: true,
//       );
//     }
//   }
//
//   Future<void> getDeviceToken() async {
//     String? token = await messaging.getToken();
//     print("token : $token");
//   }
//
//   Future<void> sendOrderNotification(String userName, String title) async {
//     final String deviceToken =
//         'fhModxj2RxanjRnFF_woFn:APA91bHLcfhbej7Jqhip-zlJ5IUW3AGa1lzvGwKyFRYH7gRiUKosRuitnq7gLh47KnG3oRwJCWtxGYLu3IrsnBIxHJ_tPrOmyhZUdgTkEpiLOV8IM8yJVvEqfOnReTAFdzovwf5RuU1W';
//
//     final NotificationData notificationData = NotificationData(
//       to: deviceToken,
//       notification: Notification(
//         title: userName, // اسم المستخدم
//         body: title, // الرسالة
//         priority: 'high',
//         androidChannelId: 'high_importance_channel',
//       ),
//       data: {}, // يمكنك إضافة المزيد من البيانات هنا إذا لزم الأمر
//     );
//
//     final NotificationApi notificationApi = NotificationApi();
//     await notificationApi.sendNotification(notificationData);
//   }
// }
