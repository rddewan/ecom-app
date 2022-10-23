
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecom_app/common/logging/logger_provider.dart';
import 'package:ecom_app/core/firebase/notification/flutter_local_notification_provider.dart';
import 'package:ecom_app/core/firebase/notification/model/received_notification.dart';
import 'package:ecom_app/core/route/go_router_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

final localPushNotificationProvider = Provider<LocalPushNotification>((ref) {
  final localNotificationsPlugin = ref.watch(flutterLocalNotificationProvider);
  final logger = ref.watch(loggerProvider('LocalPushNotification'));

  return LocalPushNotification(localNotificationsPlugin,logger, ref);

});

class LocalPushNotification {
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin;
  final Logger _logger;
  final Ref _ref;

  LocalPushNotification(this._localNotificationsPlugin, this._logger, this._ref) {
    _init();
  }

  void _init() async {

    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('ic_stat_shopping_cart'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestCriticalPermission: false,
        requestSoundPermission: false,
      ),
    );
   
    await _localNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(_notificationChannelMax());

    await _localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {        
        _logger.info(details.toString());   
        _handleMessage(details.payload);    
      },
    );
    

  }

  ///On Android, notification messages are sent to Notification 
  ///Channels which are used to control how a notification is delivered. 
  ///The default FCM channel used is hidden from users, however provides a "default" importance level. 
  ///Heads up notifications require a "max" importance level.
  void showNotification(ReceivedNotification message) async {
    //final String largeIcon = await _base64EncodedImage(message.imageUrl ?? '');
    String? bigPicture;
    if (message.imageUrl != null) {
      bigPicture = await _base64EncodedImage(message.imageUrl ?? '');
    }

    await _localNotificationsPlugin.show(
      message.id, 
      message.title, 
      message.body, 
      NotificationDetails(
        android: _androidNotificationDetail(
          bigPicture != null ? BigPictureStyleInformation(
            ByteArrayAndroidBitmap.fromBase64String(bigPicture),
          ) : null,
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      payload: message.payload,
    );
  }

  Future<String> _base64EncodedImage(String url) async {
    final response = await Dio().get<List<int>>(url, options: Options(responseType: ResponseType.bytes));
    final String base64Data = base64Encode(response.data ?? []);
    return base64Data;
  }

  AndroidNotificationDetails _androidNotificationDetail(StyleInformation? styleInformation) {
    return AndroidNotificationDetails(
      '1001',
      'General Notification',
      channelDescription: 'This is a general notification channel',
      importance: Importance.max,
      priority: Priority.max,
      channelShowBadge: true,
      styleInformation: styleInformation,
    );
  }

  AndroidNotificationChannel _notificationChannelMax() {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.', // description
      importance: Importance.max,
    );

    return channel;

  }

  void _handleMessage(String? payload) {
    final Map<String, dynamic> data = jsonDecode(payload ?? '');

    if(data['link'] != null) {
      final String link = data['link'];
      _ref.read(goRouterProvider).go(link);
    }
    
  }
  
}