import 'dart:convert';

import 'package:bigboss/src/core/common/data/models/generic_model/generic_model.dart';
import 'package:bigboss/src/features/home_page/data/models/slide_model.dart';
import 'package:dio/dio.dart';

import '../../../../core/utils/managers/http/http_manager.dart';
import '../../../../core/utils/managers/http/http_methods.dart';

abstract class BrandsDataSource {
  Future<List<GenericModel>?> getBrands();
}

class BrandsDataSourceImpl implements BrandsDataSource {
  final HttpManager httpManager;

  BrandsDataSourceImpl({
    required this.httpManager,
  });

  @override
  Future<List<GenericModel>?> getBrands() async {
    final Response response = await httpManager.request(
      path: "/Ecommerce/Ebrands",
      method: HttpMethods.Get,
    );
    List<dynamic> jsonData = json.decode(response.data);

    List<GenericModel> model = jsonData.map((json) => GenericModel.fromJson(json as Map<String, dynamic>)).toList();
    return model;
  }
}
