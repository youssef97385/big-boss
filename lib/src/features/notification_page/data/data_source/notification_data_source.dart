import 'dart:convert';
import 'package:bigboss/src/features/notification_page/data/models/notification_model.dart';
import 'package:dio/dio.dart';

import '../../../../core/utils/managers/http/http_manager.dart';
import '../../../../core/utils/managers/http/http_methods.dart';

abstract class NotificationDataSource {
  Future<List<NotificationModel>> getNotifications({required String userId});
}

class NotificationDataSourceImpl implements NotificationDataSource {
  final HttpManager httpManager;

  NotificationDataSourceImpl({
    required this.httpManager,
  });

  @override
  Future<List<NotificationModel>> getNotifications(
      {required String userId}) async {
    final Response response = await httpManager.request(
      path: "/Notifications/GetAll?userId=$userId",
      method: HttpMethods.Get,
    );

    List<dynamic> jsonData = json.decode(response.data);

    List<NotificationModel> model = jsonData
        .map((json) => NotificationModel.fromJson(json as Map<String, dynamic>))
        .toList();
    return model;
  }
}
