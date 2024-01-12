import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../../app/logic/app_settings.dart';
import '../../../../injection.dart';
import 'notification_manager.dart';
import 'notification_message_handler.dart';

class GmsNotificationsManager implements NotificationsManager {
  final NotificationMessageHandler notificationMessageHandler;
  FirebaseMessaging? _firebaseInstance;

  GmsNotificationsManager({
    required this.notificationMessageHandler,
  });

  @override
  Future<void> init() async {

    _firebaseInstance = FirebaseMessaging.instance;
    String? apnsToken = await _firebaseInstance?.getAPNSToken();
log("apnsToken $apnsToken");

    await _firebaseInstance?.requestPermission();

    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();
    notificationMessageHandler.onMessageOpenedAppGMS(initialMessage);

    FirebaseMessaging.onMessage
        .listen(notificationMessageHandler.onMessageReceived);
    FirebaseMessaging.onMessageOpenedApp
        .listen(notificationMessageHandler.onMessageOpenedAppGMS);
  }

  @override
  Future<String?> getToken() async {
    return _firebaseInstance?.getToken();
  }


}
