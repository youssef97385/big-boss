import 'dart:convert';
import 'dart:developer';
import 'package:bigboss/src/core/common/data/models/success_model/success_model.dart';
import 'package:bigboss/src/features/order_feature/modles/order_model.dart';
import 'package:bigboss/src/features/products_list/data/models/product_model.dart';
import 'package:dio/dio.dart';

import '../../../core/utils/managers/http/http_manager.dart';
import '../../../core/utils/managers/http/http_methods.dart';

abstract class SearchDataSource {
  Future<List<dynamic>> search({required String value});
}

class SearchDataSourceImpl implements SearchDataSource {
  final HttpManager httpManager;

  SearchDataSourceImpl({
    required this.httpManager,
  });

  @override
  Future<List<dynamic>> search({required String value}) async {
    final Response response = await httpManager.request(
      path: "/Ecommerce/SearchResult?language=EN&value=$value",
      method: HttpMethods.Get,
    );
    final jsonData = json.decode(response.data);




    List<dynamic> model = jsonData
        .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
        .toList();


    return model;
  }
}
