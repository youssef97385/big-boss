import 'dart:convert';
import 'package:bigboss/src/features/products_list/data/models/product_model.dart';
import 'package:dio/dio.dart';

import '../../../../core/utils/managers/http/http_manager.dart';
import '../../../../core/utils/managers/http/http_methods.dart';

abstract class ProductsDataSource {
  Future<List<ProductModel>?> getProducts(
      {required String path});
  Future<List<ProductModel>?> getProductsBySubCategoryId(
      {required int id,});
}

class ProductsDataSourceImpl implements ProductsDataSource {
  final HttpManager httpManager;

  ProductsDataSourceImpl({
    required this.httpManager,
  });

  @override
  Future<List<ProductModel>?> getProducts( {required String path,}) async {
    final Response response = await httpManager.request(
      path: "/Ecommerce/$path",
      method: HttpMethods.Get,
    );
    List<dynamic> jsonData = json.decode(response.data);

    List<ProductModel> model = jsonData
        .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
        .toList();
    return model;
  }

  @override
  Future<List<ProductModel>?> getProductsBySubCategoryId({required int id})  async {
    final Response response = await httpManager.request(
      path: "/Ecommerce/EproductsBySubCategoryId?subCategoryId=$id",
      method: HttpMethods.Get,
    );
    List<dynamic> jsonData = json.decode(response.data);

    List<ProductModel> model = jsonData
        .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
        .toList();
    return model;
  }
}
