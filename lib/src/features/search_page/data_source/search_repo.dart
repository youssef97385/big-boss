import 'package:bigboss/src/core/common/data/models/error_model/error_model.dart';
import 'package:bigboss/src/core/common/data/models/success_model/success_model.dart';
import 'package:bigboss/src/core/constants/const.dart';
import 'package:bigboss/src/core/utils/helpers/error_parser.dart';
import 'package:bigboss/src/core/utils/managers/database/database_manager.dart';
import 'package:bigboss/src/features/order_feature/data/order_data_source.dart';
import 'package:bigboss/src/features/order_feature/modles/order_model.dart';
import 'package:bigboss/src/features/products_list/data/models/product_model.dart';
import 'package:bigboss/src/features/products_list/domain/entiities/product_endtity.dart';
import 'package:bigboss/src/features/search_page/data_source/search_product_data_source.dart';
import 'package:bigboss/src/features/shopping_cart/domain/entities/cart_item_entity.dart';
import 'package:bigboss/src/injection.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/utils/managers/database/hive_service.dart';

abstract class SearchRepo {
  Future<Either<ErrorModel, List<ProductEntity>>> search(String value);
}

class SearchRepoImpl implements SearchRepo {
  final SearchDataSource dataSource;

  SearchRepoImpl({
    required this.dataSource,
  });

  @override
  Future<Either<ErrorModel, List<ProductEntity>>> search(String value) async {
    try {
      final result = await dataSource.search(
        value: value,
      );

      List<ProductEntity> products = [];
      for (ProductModel model in result ?? []) {
        String link = "";
        if (model.link?.isNotEmpty ?? false) {
          link = model.link?[0] ?? "";
        }
        products.add(ProductEntity(
          isOffer: false,
          id: model.id,
          image: link,
          enName: model.enName ??"",
          krName: model.krName??"",
          arName: model.arName??"",
          krDiscription: model.krDescription ??"",
          arDescription: model.arDescription??"",
          enDescription: model.enDescription??"",

          enShippingDetails: model.enShippingDetails ??"",
          arShippingDetails: model.arShippingDetails??"",
          krShippingDetails: model.krShippingDetails??"",
          prices: model.priceLists ?? [],
          stringColors: model.colors ?? "",
          stringSizes: model.sizes ?? "",       discountPercentage: model.discountPercentage,
        ));
      }

      return Right(products);
    } on DioError catch (e, stackTrace) {
      print("");
      return Left(errorParse(e, stackTrace));
    } catch (e, stackTrace) {
      print("EEEEEEEEEEEE  $e");
      return Left(errorParse(e, stackTrace));
    }
  }
}
