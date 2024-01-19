import 'dart:developer';

import 'package:bigboss/src/core/common/data/models/error_model/error_model.dart';
import 'package:bigboss/src/core/common/data/models/success_model/success_model.dart';
import 'package:bigboss/src/core/constants/const.dart';
import 'package:bigboss/src/core/utils/helpers/error_parser.dart';
import 'package:bigboss/src/core/utils/managers/database/database_manager.dart';
import 'package:bigboss/src/features/order_feature/data/order_data_source.dart';
import 'package:bigboss/src/features/order_feature/modles/order_model.dart';
import 'package:bigboss/src/features/products_list/data/models/product_model.dart';
import 'package:bigboss/src/features/products_list/domain/entiities/product_endtity.dart';
import 'package:bigboss/src/features/shopping_cart/domain/entities/cart_item_entity.dart';
import 'package:bigboss/src/injection.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/utils/managers/database/hive_service.dart';

abstract class OrderRepo {
  Future<Either<ErrorModel, SuccessModel>> crateOrder(int addressId);

  Future<Either<ErrorModel, List<OrderModel>>> getAllOrders();

  Future<Either<ErrorModel, List<ProductEntity>>> getOrderById(int orderId);
}

class OrderRepoImpl implements OrderRepo {
  final OrderDataSource orderDataSource;
  final HiveService hiveService;

  OrderRepoImpl({required this.orderDataSource, required this.hiveService});

  @override
  Future<Either<ErrorModel, SuccessModel>> crateOrder(int addressId) async {
    try {
      List<CartItemEntity> products =
          await hiveService.getBoxes<CartItemEntity>(kCartKey);

      List<Map<String, dynamic>> mapProducts = [];
      List<Map<String, dynamic>> mapOffers = [];

      double netTotal = 0;
      bool isOneProductsOffer = false;
      for (CartItemEntity cartItemEntity in products) {
        if (cartItemEntity.isOffer ?? false) {
          isOneProductsOffer = true;
          mapOffers.add({
            "offerId": cartItemEntity.id,
            "qty": cartItemEntity.count,
            "price": cartItemEntity.price,
            "remark": "string"
          });
        } else {
          mapProducts.add({
            "productId": cartItemEntity.id,
            "qty": cartItemEntity.count,
            "price": cartItemEntity.price,
            "remark": "string"
          });
        }

        netTotal += (cartItemEntity.price * cartItemEntity.count) ?? 0;
      }

      var data = {
        "addressId": addressId,
        "remark": "string",
        "orderedProducts": mapProducts,
        "orderedOffers": mapOffers,
        "isOffer": isOneProductsOffer,
        "coupenCodeCode": "string",
        "netTotal": netTotal
      };

      final result = await orderDataSource.createOrder(path: "", data: data);

      return Right(result);
    } on DioError catch (e, stackTrace) {
      print("");
      return Left(errorParse(e, stackTrace));
    } catch (e, stackTrace) {
      print("LEFFFFFFF $e");
      return Left(errorParse(e, stackTrace));
    }
  }

  @override
  Future<Either<ErrorModel, List<OrderModel>>> getAllOrders() async {
    try {
      String? userId = serviceLocator<DatabaseManager>().getData("USERID");

      final result = await orderDataSource.getAllOrders(userId ?? "");

      return Right(result ?? []);
    } on DioError catch (e, stackTrace) {
      print("ERROR222 $e");
      return Left(errorParse(e, stackTrace));
    } catch (e, stackTrace) {
      print("LEFFFFFFF $e");
      return Left(errorParse(e, stackTrace));
    }
  }

  @override
  Future<Either<ErrorModel, List<ProductEntity>>> getOrderById(
      int orderId) async {
    try {
      String? userId = serviceLocator<DatabaseManager>().getData("USERID");

      final result = await orderDataSource.getOrderById(userId ?? "",orderId);

      List<ProductEntity> products = [];

      for (OrderModel model in result ?? []) {
        products.add(ProductEntity(
            enName: model.products?.enName ?? "",
            arName: model.products?.arName ?? "",
            krName: model.products?.krName ?? "",
            enDescription: model.products?.enDescription ?? "",
            arDescription: model.products?.arDescription ?? "",
            krDiscription: model.products?.krDescription ?? "",
            enShippingDetails: model.products?.enShippingDetails ?? "",
            arShippingDetails: model.products?.arShippingDetails ?? "",
            krShippingDetails: model.products?.krShippingDetails ?? "",
            stringColors: model.products?.colors ?? "",
            stringSizes: model.products?.sizes ?? "",
            prices: model.products?.priceLists ?? [],
            discountPercentage: model.products?.discountPercentage,
            isOffer: false,qty: model.qty));
      }

      return Right(products ?? []);
    } on DioError catch (e, stackTrace) {
      print("ERROR222 $e");
      return Left(errorParse(e, stackTrace));
    } catch (e, stackTrace) {
      print("LEFFFFFFF $e");
      return Left(errorParse(e, stackTrace));
    }
  }
}
