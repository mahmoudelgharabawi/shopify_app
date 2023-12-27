import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shopify_app/firebase_options.dart';

class PushNotificationService {
  static FirebaseMessaging? fcm;
  static bool _isInialized = false;
  static bool _isTokenInit = false;

  static int _tries = 0;

  static Future init() async {
    if (_isInialized) {
      await _sendToken();
      return;
    }
    fcm = FirebaseMessaging.instance;
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // Forground Notification
      handleOnNotificationReceived(message, isForground: true);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      // App Background Not killed Notification
      handleOnNotificationReceived(message);
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    try {
      await _sendToken();
      _isInialized = true;
    } catch (e) {
      print(
          '>>>>>>Exeption while doing operations in push notification init${e.toString()}');
      _isInialized = true;
      if (_tries <= 20) {
        init();
        _tries++;
      }
    }
  }

  /// used when the user logout
  static void onPushNotificationClosed() {
    _isTokenInit = false;
  }

  static Future<void> _sendToken() async {
    if (_isTokenInit) return;
    var userToken = await fcm?.getToken();

    await FirebaseFirestore.instance
        .collection('tokens')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .set({"token": userToken});
    // end of update user data
    debugPrint(
        '||||||||||||||||||||||||||||||||||||||||||||||||||| New Token : ${userToken}');
    _isTokenInit = true;
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    debugPrint('A bg message just showed up :  ${message.messageId}');
  }

  static void handleOnNotificationReceived(RemoteMessage message,
      {bool isForground = false}) async {
    RemoteNotification? notification = message.notification;
    var payLoad;
    print(
        '>>>>>>>>>>>>>>>>>>>>>>>> notification recieved ${message.data['payload']}');
    if (message.data['payload'] != null) {
      payLoad = jsonDecode(message.data['payload']);
      try {
        switch (payLoad["type"].toString()) {}
      } catch (e) {
        print('error ${e}');
      }
    }
    if (notification != null) {
      if (isForground) {
        showSimpleNotification(Text('${message.notification?.title}'),
            subtitle: Text('${message.notification?.body}'),
            background: Colors.green);
      }
    }
  }

  static void handleOnNotificationClicked(dynamic payLoad) async {
    try {
      switch (payLoad["type"].toString()) {}
    } catch (e) {
      print('error ${e}');
    }
  }

  static void checkNotificationOnKilledApp() async {
    RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      handleOnNotificationReceived(message);
    }
  }
}
