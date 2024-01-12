import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/routes/router.gr.dart';
import '../../../../injection.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class NotificationMessageHandler {
  void onMessageReceived(message);

  void onMessageOpenedAppGMS(message);

  void onNotificationOpenAppHMS(initialNotification);

  void onMessageReceiveError(error);
}

class NotificationMessageHandlerImpl implements NotificationMessageHandler {
  @override
  void onMessageReceived(message) {
    if (message == null) return;
    final String title = message.notification?.title ?? "";
    final String body = message.notification?.body ?? "";

    print("BODY $body");

    handleNotification({"message":"asdsa"});

    bool isIphone = Platform.isIOS;

    final Map<String, dynamic> notificationData = message.data;
    final String? notificationAction = notificationData['action'];

    bool isImageAvilable = (message.notification?.apple?.imageUrl != null ||
        message.notification?.android?.imageUrl != null);
    _showNotificationDialog(
      title,
      body,
      notificationAction,
      isImageAvilable
          ? isIphone
          ? "${message.notification?.apple?.imageUrl}"
          : "${message.notification?.android?.imageUrl}"
          : "",
    );
  }

  @override
  void onMessageOpenedAppGMS(message) {
    if (message == null) return;

    final Map<String, dynamic> notificationData = message.data;
    final String? notificationAction = notificationData['action'];
    final BuildContext currentContext =
    serviceLocator<AppRouter>().navigatorKey.currentContext!;

    _checkForDeeplink(currentContext, notificationAction);
  }

  @override
  void onNotificationOpenAppHMS(initialNotification) {
    if (initialNotification == null) return;
    final Map<String, dynamic>? initialNotificationData =
    initialNotification as Map<String, dynamic>?;

    if (initialNotificationData == null) return;
  }

  @override
  void onMessageReceiveError(error) {
    final PlatformException e = error as PlatformException;
    debugPrint("_onMessageReceiveError ${e.message ?? ""}");
  }

  void _showNotificationDialog(
      String title,
      String body,
      String? notificationAction,
      String? image,
      ) async {

  }

  void _checkForDeeplink(
      BuildContext currentContext, String? notificationAction) {

    if (notificationAction == null) {
      final bool isSelectedRouteActive =
      serviceLocator<AppRouter>().isPathActive('notification');

      if (isSelectedRouteActive) {
        currentContext.router.pop();
      }
      currentContext.router.pushNamed('notification');

      return;
    }






    var path = notificationAction.split('/')[0];
    var args = notificationAction.split('/');
    args.removeAt(0);

    final bool isSelectedRouteActive =
    serviceLocator<AppRouter>().isPathActive(path);

    if (isSelectedRouteActive && !notificationAction.contains('main')) {
      currentContext.router.pop();
    }

    currentContext.router.pushNamed(notificationAction);
  }


  void handleNotification(Map<String, dynamic> data) {
    // Parse JSON and get the desired attribute
    String message = parseJsonAndGetAttribute(data);

    // Show notification
    showNotification(message);
  }

  String parseJsonAndGetAttribute(Map<String, dynamic> data) {
    // Parse your JSON here and extract the desired attribute
    // For example, if the JSON has a key 'message', you can do:
    return data['message'] ?? 'Default Message';
  }

  Future<void> showNotification(String message) async {
    // Create a notification
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'your_channel_id',
      'Your Channel Name',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.show(
      0,
      'Notification Title',
      message,
      platformChannelSpecifics,
    );
  }

}
