import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:moleculis/models/notification/notification_model.dart';

class NotificationUtils {
  static final FlutterLocalNotificationsPlugin localNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future<bool> requestPermission() async {
    if (Platform.isIOS) {
      final FirebaseMessaging messaging = FirebaseMessaging.instance;

      await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    }
    return true;
  }

  static Future<void> onPushNotificationTap({
    required Map<String, dynamic> message,
    required PushNotificationConfigureType notificationConfigureType,
  }) async {
    final notificationType = message['notificationType'];
    // TODO: lead to a corresponding screen
    print('NotificationType: $notificationType');
  }

  static void initNotificationService() {
    try {
      FirebaseMessaging.instance
          .getToken()
          .then((token) => print('FCM token: $token'));
      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        _onNotificationTap(
          message: message.data,
          notificationConfigureType: PushNotificationConfigureType.resume,
        );
      });
      FirebaseMessaging.onMessage.listen((message) async {
        await _showNotification(message.data);
      });
    } catch (e) {
      if (e is FirebaseException) {
        if (e.code == 'permission-blocked') {
          print('No notifications permissions');
          return;
        }
      }
    }
  }

  static Future<void> _showNotification(Map<String, dynamic> message) async {
    final android = AndroidNotificationDetails(
      'com.conceive.moments.notifications',
      'moments',
      'channel description',
      playSound: true,
      enableVibration: true,
      importance: Importance.max,
      priority: Priority.high,
    );
    final title = message['title'];
    final body = message['text'];
    return await localNotificationsPlugin.show(
      0,
      title,
      body,
      NotificationDetails(android: android, iOS: IOSNotificationDetails()),
      payload: json.encode(message),
    );
  }

  static void _onNotificationTap({
    required Map<String, dynamic> message,
    required PushNotificationConfigureType notificationConfigureType,
  }) {
    NotificationUtils.onPushNotificationTap(
      message: message,
      notificationConfigureType: notificationConfigureType,
    );
  }

  static String? translateNotification(NotificationModel notification) {
    switch (notification.notificationType) {
      default:
        return notification.text;
    }
  }
}
