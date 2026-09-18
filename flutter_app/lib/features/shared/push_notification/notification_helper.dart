import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_sixvalley_ecommerce/features/shared/push_notification/models/notification_body.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
  // Background message handling
}

class NotificationHelper {
  static Future<void> initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('notification_icon');
    const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings();
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(settings: initializationSettings, onDidReceiveNotificationResponse: (payload) {});
  }

  static NotificationBody convertNotification(Map<String, dynamic> data) {
    return NotificationBody.fromJson(data);
  }

  static Future<void> showNotification(
    NotificationBody notification, {
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'multishop_tchad',
      'MultiShop Tchad',
      channelDescription: 'Notifications for MultiShop Tchad',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
    );
    const DarwinNotificationDetails iOSPlatformChannelSpecifics = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(id: id, title: title ?? notification.title ?? 'MultiShop Tchad', body: body ?? notification.messageKey ?? '', notificationDetails: platformChannelSpecifics, payload: payload ?? notification.toJson().toString());
  }

  static Future<void> subscribeToAuctionTopics(int auctionId) async {
    try {
      await FirebaseMessaging.instance.subscribeToTopic('auction_went_live_$auctionId');
      await FirebaseMessaging.instance.subscribeToTopic('auction_outbid_$auctionId');
    } catch (e) {
      debugPrint('FCM topic subscription failed for auctionId=$auctionId: $e');
    }
  }

  static Future<void> unsubscribeFromAuctionTopics(int auctionId) async {
    try {
      await FirebaseMessaging.instance.unsubscribeFromTopic('auction_went_live_$auctionId');
      await FirebaseMessaging.instance.unsubscribeFromTopic('auction_outbid_$auctionId');
    } catch (e) {
      debugPrint('FCM topic unsubscription failed for auctionId=$auctionId: $e');
    }
  }
}

