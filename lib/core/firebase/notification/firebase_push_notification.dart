
import 'dart:convert';

import 'package:ecom_app/core/firebase/notification/firebase_background_messaging.dart';
import 'package:ecom_app/core/firebase/notification/firebase_messaging_provider.dart';
import 'package:ecom_app/core/firebase/notification/local_push_notification.dart';
import 'package:ecom_app/core/firebase/notification/model/received_notification.dart';
import 'package:ecom_app/core/route/go_router_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final firebasePushNotificationProvider = Provider<FirebasePushNotification>((ref) {
  final messaging = ref.watch(firebaseMessagingProvider);
  final localPushNotification = ref.watch(localPushNotificationProvider);

  return FirebasePushNotification(messaging,localPushNotification, ref);

});

class FirebasePushNotification {
  final FirebaseMessaging _messaging;
  final LocalPushNotification _localPushNotification;
  final Ref _ref;

  FirebasePushNotification(this._messaging, this._localPushNotification, this._ref) {
    _init();
    _onFirebaseMessageReceived();
    _setupInteractedMessage();
  }

  void _init() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
    } else {
      debugPrint('User declined or has not accepted permission');
    }

    ///Foreground notifications (also known as "heads up")
    /// are those which display for a brief period of time above existing applications, 
    /// and should be used for important events.
    /// Android & iOS have different behaviors when handling notifications whilst applications
    ///  are in the foreground so keep this in mind whilst developing.

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    ///Handling messages whilst your application is in the background is a little different. 
    ///Messages can be handled via the onBackgroundMessage handler. 
    ///When received, an isolate is spawned (Android only, iOS/macOS does not require a separate isolate) 
    ///allowing you to handle messages even when your application is not running.    
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  void _onFirebaseMessageReceived() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      Map<String, dynamic> data = message.data;

      if (notification != null && android != null)  {
        _localPushNotification.showNotification(
          ReceivedNotification(
            notification.hashCode, 
            notification.title, 
            notification.body, 
            android.imageUrl, 
            jsonEncode(data),
          ),
        );
        
      }
    });
  }

  Future<void> _setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage = await _messaging.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }
  
  void _handleMessage(RemoteMessage message) {
    if(message.data['link'] != null) {
      final String link = message.data['link'];
      _ref.read(goRouterProvider).go(link);
    }
    
  }

  /// Returns the default FCM token for this device.
  Future<String?> getFirebaseToken() async {
    return await _messaging.getToken();
  }

  
  /// On iOS/MacOS, it is possible to get the users APNs token.
  /// This may be required if you want to send messages to your iOS/MacOS devices without using the FCM service.
  Future<String?> getAPNSToken() async {
    return await _messaging.getAPNSToken();
  }

  /// Returns the current [NotificationSettings].
  /// To request permissions, call [requestPermission].
  Future<NotificationSettings> getNotificationSettings() async {
    return await _messaging.getNotificationSettings();
  }



  
}