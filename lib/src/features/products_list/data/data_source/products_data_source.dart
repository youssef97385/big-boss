import 'dart:convert';
import 'dart:developer';
import 'package:bigboss/src/features/products_list/data/models/product_model.dart';
import 'package:bigboss/src/features/products_list/data/models/products_response_model.dart';
import 'package:dio/dio.dart';

import '../../../../core/utils/managers/http/http_manager.dart';
import '../../../../core/utils/managers/http/http_methods.dart';

abstract class ProductsDataSource {
  Future<ProductsResponseModel?> getProducts({required String path});
  Future<ProductsResponseModel?> getProductsBySubCategoryId({
    required int id,required page
  });
}

class ProductsDataSourceImpl implements ProductsDataSource {
  final HttpManager httpManager;

  ProductsDataSourceImpl({
    required this.httpManager,
  });

  @override
  Future<ProductsResponseModel?> getProducts({
    required String path,
  }) async {
    final Response response = await httpManager.request(
      path: "/Ecommerce/$path",
      method: HttpMethods.Get,
    );
    ProductsResponseModel model = ProductsResponseModel.fromJson(json.decode(response.data) as Map<String,dynamic>);

    return model;
  }

  @override
  Future<ProductsResponseModel?> getProductsBySubCategoryId(
      {required int id,required page}) async {
    final Response response = await httpManager.request(
      path: "/Ecommerce/EproductsBySubCategoryIdP?PageNumber=$page&PageSize=20&subCategoryId=$id",
      method: HttpMethods.Get,
    );


    ProductsResponseModel model = ProductsResponseModel.fromJson(json.decode(response.data) as Map<String,dynamic>);

    return model;
  }
}
