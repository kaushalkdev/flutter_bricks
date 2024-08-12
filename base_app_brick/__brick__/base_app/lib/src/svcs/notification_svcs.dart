import 'dart:async';
import 'dart:convert';

import 'package:base_app/src/app_expns.dart';
import 'package:base_app/src/locator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';

abstract class NotificationSvcs {
  Future<void> init();

  Future<Map<String, dynamic>?> onNotificationTapFirstLaunch();

  /// for foreground and background streams
  Stream<Map<String, dynamic>> get onNotificationTapStream;

  void dispose();
}

class FrbNotificationSvs extends NotificationSvcs {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final AndroidNotificationChannel _channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  final FlutterLocalNotificationsPlugin _localNotification =
      FlutterLocalNotificationsPlugin();

  final StreamController<Map<String, dynamic>> _notificationTapStream =
      StreamController.broadcast();

  @override
  Future<void> init() => _notificationSetup();

  @override
  Future<Map<String, dynamic>?> onNotificationTapFirstLaunch() async {
    // get remte ntfn which causes app launch.
    var ntfn = await _messaging.getInitialMessage();

    // get local ntfn which causes app to launch.
    var localNtfn = await _localNotification.getNotificationAppLaunchDetails();
    Map<String, dynamic>? localNtfnPayload;
    if (localNtfn != null && localNtfn.didNotificationLaunchApp) {
      localNtfnPayload = jsonDecode(localNtfn.notificationResponse!.payload!);
    }

    // return the one which is non nullable.
    return ntfn?.data ?? localNtfnPayload;
  }

  @override
  Stream<Map<String, dynamic>> get onNotificationTapStream =>
      _notificationTapStream.stream;

  @override
  void dispose() {
    _notificationTapStream.close();
  }

  Future<void> _notificationSetup() async {
    try {
      var settings = await _messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      switch (settings.authorizationStatus) {
        case AuthorizationStatus.authorized:

          // iOS configuration for foreground notifications
          await _messaging.setForegroundNotificationPresentationOptions(
            alert: true, // Required to display a heads up notification
            badge: true,
            sound: true,
          );

          var token = await _messaging.getToken();
          Locator.i.get<Logger>().i(token);

          // Android configuration for foreground notifications
          await _localNotification
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.createNotificationChannel(_channel);

          // Initializing the flutter local notifications.
          await _localNotification.initialize(
            const InitializationSettings(
              // TODO update the icon if updating icons on native side
              android: AndroidInitializationSettings('@mipmap/ic_launcher'),
              iOS: DarwinInitializationSettings(),
            ),
            onDidReceiveNotificationResponse: (details) {
              if (details.payload != null) {
                _notificationTapStream.add(jsonDecode(details.payload!));
              }
            },
          );

          // register callbacks
          FirebaseMessaging.onMessage.listen(_showNotificationInForeground);
          FirebaseMessaging.onMessageOpenedApp.listen(_messageListener);
          FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);

          break;

        case AuthorizationStatus.denied:
        case AuthorizationStatus.notDetermined:
          throw const NotificationExpn(message: 'Permission denied');

        case AuthorizationStatus.provisional:
          throw const NotificationExpn(message: 'Provisional permission.');
      }
    } catch (e, s) {
      Locator.i.get<Logger>().e(e.toString(), stackTrace: s);
    }
  }

  void _showNotificationInForeground(RemoteMessage message) {
    // show notification in foreground
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    // If `onMessage` is triggered with a notification, construct our own
    // local notification to show to users using the created channel.
    if (notification != null && android != null) {
      _localNotification.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(_channel.id, _channel.name,
                channelDescription: _channel.description,
                importance: _channel.importance,
                icon: android.smallIcon,
                priority: Priority.high),
          ));
    }
  }

  void _messageListener(RemoteMessage event) {
    _notificationTapStream.add(event.data);
  }
}

@pragma('vm:entry-point')
Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  // do some calcuations in background if required.
  if (kDebugMode) {
    print('FirebaseMessaging| Background Handler | Message: ${message.data}');
  }
}
