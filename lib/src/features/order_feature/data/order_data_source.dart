import 'dart:convert';
import 'package:bigboss/src/core/common/data/models/success_model/success_model.dart';
import 'package:bigboss/src/features/order_feature/modles/order_model.dart';
import 'package:dio/dio.dart';

import '../../../core/utils/managers/http/http_manager.dart';
import '../../../core/utils/managers/http/http_methods.dart';

abstract class OrderDataSource {
  Future<SuccessModel> createOrder(
      {required String path, required Map<String, dynamic> data});

  Future<List<OrderModel>?> getAllOrders(String userId);
}

class OrderDataSourceImpl implements OrderDataSource {
  final HttpManager httpManager;

  OrderDataSourceImpl({
    required this.httpManager,
  });

  @override
  Future<SuccessModel> createOrder(
      {required String path, required Map<String, dynamic> data}) async {
    final Response response = await httpManager.request(
      path: "/Ecommerce/CreateOrder",
      method: HttpMethods.Post,
      payload: data,
    );
    print("RESSS $data");
    Map<String, dynamic> jsonData = json.decode(response.data);

    SuccessModel model = SuccessModel(message: "${jsonData["message"]}");

    return model;
  }

  @override
  Future<List<OrderModel>?> getAllOrders(String userId) async {
    final Response response = await httpManager.request(
      path: "/Ecommerce/EUserOrders?userId=$userId",
      method: HttpMethods.Get,
    );

    List<dynamic> jsonData = json.decode(response.data);

    List<OrderModel> model = jsonData
        .map((json) => OrderModel.fromJson(json as Map<String, dynamic>))
        .toList();
    return model;
  }
}
