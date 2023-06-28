import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:webant_internship/helpers/helpers.dart';

import '../firebase_options.dart';

class FirebaseNotificationHelper {
  static Future<void> initializeHelper() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen(
      (message) {
        if (message.notification != null) {
          NotificationHelper.showNotification(
            title: message.notification!.title!,
            body: message.notification!.body!,
            imageUrl: message.notification!.android!.imageUrl,
          );
        }
      },
    );
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await NotificationHelper.initializeNotifications();

  if (message.notification != null) {
    await NotificationHelper.showNotification(
      title: message.notification!.title!,
      body: message.notification!.body!,
    );
  }
}
