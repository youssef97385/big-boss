import 'dart:convert';

import 'package:bigboss/src/features/home_page/data/models/slide_model.dart';
import 'package:bigboss/src/features/products_list/data/models/product_model.dart';
import 'package:dio/dio.dart';

import '../../../../core/utils/managers/http/http_manager.dart';
import '../../../../core/utils/managers/http/http_methods.dart';

abstract class HomeDataSource {
  Future<List<SlideModel>?> getSlides();

  Future<List<ProductModel>?> getNewProducts();
}

class HomeDataSourceImpl implements HomeDataSource {
  final HttpManager httpManager;

  HomeDataSourceImpl({
    required this.httpManager,
  });

  @override
  Future<List<SlideModel>?> getSlides() async {
    final Response response = await httpManager.request(
      path: "/Ecommerce/Slides",
      method: HttpMethods.Get,
    );
    List<dynamic> jsonData = json.decode(response.data);

    List<SlideModel> slides = jsonData
        .map((json) => SlideModel.fromJson(json as Map<String, dynamic>))
        .toList();
    return slides;
  }

  @override
  Future<List<ProductModel>?> getNewProducts() async {
    final Response response = await httpManager.request(
      path: "/Ecommerce/HomeNewProducts",
      method: HttpMethods.Get,
    );
    List<dynamic> jsonData = json.decode(response.data);

    List<ProductModel> products = jsonData
        .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
        .toList();
    return products;
  }
}
