import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationClass {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  static Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      final dynamic data = message['data'];
      debugPrint('from background data: $data');
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
      debugPrint('from background notification: $notification');
    }

    debugPrint('from background message: $message');
  }

  void init() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        debugPrint('onMessage: $message');
        // _showItemDialog(message);
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        debugPrint('onLaunch: $message');
        // _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        debugPrint('onResume: $message');
        // _navigateToItemDetail(message);
      },
    );
  }

  Future<void> subscribeToChannel(String channelName) async {
    await _firebaseMessaging.subscribeToTopic(channelName);
  }

  Future<void> unsubscribeToChannel(String channelName) async {
    await _firebaseMessaging.unsubscribeFromTopic(channelName);
  }
}
