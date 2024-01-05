import 'dart:developer';

import 'package:bigboss/src/features/offers/data/data_source/offer_data_source.dart';
import 'package:bigboss/src/features/offers/data/models/offer_model.dart';
import 'package:bigboss/src/features/products_list/data/models/product_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/common/data/models/error_model/error_model.dart';
import '../../../../core/utils/helpers/error_parser.dart';
import '../../../products_list/domain/entiities/product_endtity.dart';
import '../../domain/offer_entity.dart';

abstract class OfferRepository {
  Future<Either<ErrorModel, List<OfferEntity>>> getOffers();

  Future<Either<ErrorModel, List<ProductEntity>>> getProductsByOfferId(id);
}

class OfferRepositoryImpl implements OfferRepository {
  final OffersDataSource offersDataSource;

  OfferRepositoryImpl({
    required this.offersDataSource,
  });

  @override
  Future<Either<ErrorModel, List<OfferEntity>>> getOffers() async {
    try {
      final data = await offersDataSource.getOffers();

      List<OfferEntity> offers = [];
     for(OfferModel model in data ?? []){
       offers.add(

           OfferEntity(
             id:model.id,
             enName:model.enName,
             arName:model.arName,
       krName:model.krName,
           link:model.link,
            netTotal:model.netTotal,
          arDescritpion:model.arDescritpion,
          krDescription:model.krDescription,
           enDescription:model.enDescription,
           )
       );
     }


      return Right(offers ?? []);
    } catch (error, stackTrace) {
      print("error# $error");
      return Left(errorParse(error, stackTrace));
    }
  }

  @override
  Future<Either<ErrorModel, List<ProductEntity>>> getProductsByOfferId(
      id) async {
    try {
      final data = await offersDataSource.getOfferProductsById(id);
      List<ProductEntity> products = [];
      for (ProductModel model in data ?? []) {
        String link = "";
        if (model.link?.isNotEmpty ?? false) {
          link = model.link?[0] ?? "";
        }
        products.add(ProductEntity(
          isOffer: true,
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
          stringSizes: model.sizes ?? "",
        ));
      }
      return Right(products ?? []);
    } catch (error, stackTrace) {
      print("error# $error");
      return Left(errorParse(error, stackTrace));
    }
  }
}
