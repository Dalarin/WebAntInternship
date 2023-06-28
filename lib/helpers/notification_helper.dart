import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  static final notificationPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> initializeNotifications() async {
    await notificationPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();

    const android = AndroidInitializationSettings('mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);
    await notificationPlugin.initialize(settings);
  }

  static Future<void> showNotification({
    required String title,
    required String body,
    String? imageUrl,
  }) async {
    return notificationPlugin.show(
      0,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channelId',
          'channelName',
          importance: Importance.max,
        ),
      ),
    );
  }
}
