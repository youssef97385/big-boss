import 'dart:convert';
import 'dart:developer';

import 'package:bigboss/src/features/offers/data/models/offer_model.dart';
import 'package:dio/dio.dart';

import '../../../../core/utils/managers/http/http_manager.dart';
import '../../../../core/utils/managers/http/http_methods.dart';
import '../../../products_list/data/models/product_model.dart';

abstract class OffersDataSource {
  Future<List<OfferModel>?> getOffers();

  Future<List<ProductModel>> getOfferProductsById(id);
}

class OffersDataSourceImpl implements OffersDataSource {
  final HttpManager httpManager;

  OffersDataSourceImpl({
    required this.httpManager,
  });

  @override
  Future<List<OfferModel>?> getOffers() async {
    final Response response = await httpManager.request(
      path: "/Ecommerce/Eoffers",
      method: HttpMethods.Get,
    );
    List<dynamic> jsonData = json.decode(response.data);

    List<OfferModel> model = jsonData
        .map((json) => OfferModel.fromJson(json as Map<String, dynamic>))
        .toList();
    return model;
  }

  @override
  Future<List<ProductModel>> getOfferProductsById(id) async {
    final Response response = await httpManager.request(
      path: "/Ecommerce/EofferedProductsByOfferId?offerId=$id",
      method: HttpMethods.Get,
    );
    log("model1234 $response");
    List<dynamic> jsonData = json.decode(response.data);

    List<ProductModel> model = jsonData
        .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
        .toList();
    log("model123 $model");
    return model;
  }
}
