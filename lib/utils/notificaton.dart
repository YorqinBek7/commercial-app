import 'package:commercial_app/main.dart';
import 'package:commercial_app/screens/notification_screen/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  static final LocalNotification notification = LocalNotification._();
  factory LocalNotification() => notification;
  LocalNotification._();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void init() {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings("app_icon");

    DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );
    flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      ),
      onDidReceiveNotificationResponse: onDidRecieveNotificationResponse,
    );
    flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestPermission() ??
        false;
  }

  void onDidRecieveNotificationResponse(
    NotificationResponse notificationResponse,
  ) async {
    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => const NotificationScreen(),
      ),
    );
  }

  void onDidRecieveBackgorundNotificationResponse(
    NotificationResponse notificationResponse,
  ) async {
    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => const NotificationScreen(),
      ),
    );
  }

  final AndroidNotificationChannel androidChannel =
      const AndroidNotificationChannel(
    "super_shop",
    "Super Shop",
    importance: Importance.defaultImportance,
    description: "Super Shop description",
  );
  void showNotification(String data, int id, String title, String body) {
    flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidChannel.id,
          androidChannel.name,
          priority: Priority.defaultPriority,
          enableLights: true,
          onlyAlertOnce: true,
          showProgress: true,
          icon: "app_icon",
          importance: Importance.defaultImportance,
          largeIcon: const DrawableResourceAndroidBitmap("app_icon"),
        ),
      ),
      payload: data,
    );
  }

  void cancelNotification() {
    flutterLocalNotificationsPlugin.cancelAll();
  }

  void cancelNotificationById(int id) {
    flutterLocalNotificationsPlugin.cancel(id);
  }
}
