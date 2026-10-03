
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:multishop_tchad/features/shared/push_notification/models/notification_body.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:multishop_tchad/main.dart';
import 'package:multishop_tchad/core/helpers/route_helper.dart';
import 'package:multishop_tchad/features/vendor/chat/controllers/chat_controller.dart';
import 'package:multishop_tchad/features/vendor/chat/screens/inbox_screen.dart';

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
    await flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        try {
          if (response.payload != null && response.payload!.isNotEmpty) {
            final data = jsonDecode(response.payload!);
            final payload = NotificationBody.fromJson(data);
            if (payload.type == 'chatting' || payload.type == 'message') {
              if (navigatorKey.currentContext != null) {
                Navigator.of(navigatorKey.currentContext!).push(
                  MaterialPageRoute(builder: (_) => const InboxScreen()),
                );
              }
            } else if (payload.type == 'order' && payload.orderId != null) {
              if (navigatorKey.currentContext != null) {
                RouterHelper.getOrderDetailsScreenRoute(
                  action: RouteAction.push,
                  orderId: payload.orderId!,
                  isNotification: true,
                );
              }
            }
          }
        } catch (_) {}
      },
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      try {
        final title = message.notification?.title ?? message.data['title'];
        final body = message.notification?.body ?? message.data['body'] ?? message.data['message'];
        final notificationBody = convertNotification(message.data);

        await showNotification(
          notificationBody,
          title: title,
          body: body,
          payload: jsonEncode(message.data),
        );

        if (message.data['type'] == 'chatting' || message.data['type'] == 'message') {
          if (navigatorKey.currentContext != null) {
            Provider.of<ChatController>(navigatorKey.currentContext!, listen: false).fetchUnreadCount();
          }
        }
      } catch (e) {
        debugPrint('Error in onMessage: $e');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      try {
        final payload = convertNotification(message.data);
        if (payload.type == 'chatting' || payload.type == 'message') {
          if (navigatorKey.currentContext != null) {
            Navigator.of(navigatorKey.currentContext!).push(
              MaterialPageRoute(builder: (_) => const InboxScreen()),
            );
          }
        } else if (payload.type == 'order' && payload.orderId != null) {
          if (navigatorKey.currentContext != null) {
            RouterHelper.getOrderDetailsScreenRoute(
              action: RouteAction.push,
              orderId: payload.orderId!,
              isNotification: true,
            );
          }
        }
      } catch (_) {}
    });
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

