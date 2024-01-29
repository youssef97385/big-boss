import 'package:bigboss/src/core/common/data/models/generic_model/generic_model.dart';
import 'package:bigboss/src/core/common/domain/entites/generic_entity.dart';
import 'package:bigboss/src/features/home_page/data/home_source/accounts_data_source.dart';
import 'package:bigboss/src/features/home_page/data/home_source/brands_data_source.dart';
import 'package:bigboss/src/features/home_page/data/home_source/categories_data_source.dart';
import 'package:bigboss/src/features/home_page/data/home_source/countries_data_source.dart';
import 'package:bigboss/src/features/home_page/data/home_source/home_data_source.dart';
import 'package:bigboss/src/features/home_page/data/models/slide_model.dart';
import 'package:bigboss/src/features/home_page/data/models/slides_response_model.dart';
import 'package:bigboss/src/features/home_page/domain/entities/slide_entity.dart';
import 'package:bigboss/src/features/products_list/domain/entiities/product_endtity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/common/data/models/error_model/error_model.dart';
import '../../../../core/utils/helpers/error_parser.dart';
import '../../../products_list/data/models/product_model.dart';
import '../../domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataSource homeDataSource;
  final BrandsDataSource brandsDataSource;
  final CategoriesDataSource categoriesDataSource;
  final CountriesDataSource countriesDataSource;
  final AccountsDataSource accountsDataSource;

  HomeRepositoryImpl({
    required this.homeDataSource,
    required this.brandsDataSource,
    required this.categoriesDataSource,
    required this.countriesDataSource,
    required this.accountsDataSource,
  });

  @override
  Future<Either<ErrorModel, List<SlideEntity>>> getSlides() async {
    try {
      final data = await homeDataSource.getSlides();

      final List<SlideEntity> slides = [];

      for (SlideModel slideModel in data ?? []) {
        slides.add(
            SlideEntity(series: slideModel.series, image: slideModel.link));
      }

      return Right(slides);
    } catch (error, stackTrace) {
      print("error# $error");
      return Left(errorParse(error, stackTrace));
    }
  }

  @override
  Future<Either<ErrorModel, List<GenericEntity>>> getBrands() async {
    try {
      final data = await brandsDataSource.getBrands();

      final List<GenericEntity> brands = [];

      for (GenericModel model in data ?? []) {
        brands.add(GenericEntity(
          id: model.id,
          image: model.link,
          enName: model.enName ?? "",
          krName: model.krName ?? "",
          arName: model.arName ?? "",
        ));
      }

      return Right(brands);
    } catch (error, stackTrace) {
      return Left(errorParse(error, stackTrace));
    }
  }

  @override
  Future<Either<ErrorModel, List<GenericEntity>>> getCategories() async {
    try {
      final data = await categoriesDataSource.getCategories();

      final List<GenericEntity> brands = [];

      for (GenericModel model in data ?? []) {
        print(
            "CATEGORIES are ${model.enName} the subs are:==> ${model.subCategories}");
        final List<GenericEntity> subCats = [];
        for (GenericModel sub in model.subCategories ?? []) {
          subCats.add(GenericEntity(
            id: sub.id,
            image: sub.link,
            enName: sub.enName ?? "",
            krName: sub.krName ?? "",
            arName: sub.arName ?? "",
          ));
        }

        brands.add(GenericEntity(
          id: model.id,
          image: model.link,
          enName: model.enName ?? "",
          krName: model.krName ?? "",
          arName: model.arName ?? "",
          genericEntityList: subCats,
        ));
      }

      return Right(brands);
    } catch (error, stackTrace) {
      return Left(errorParse(error, stackTrace));
    }
  }

  @override
  Future<Either<ErrorModel, List<GenericEntity>>> getCountries() async {
    try {
      final data = await countriesDataSource.getCountries();

      final List<GenericEntity> brands = [];

      for (GenericModel model in data ?? []) {
        brands.add(GenericEntity(
          id: model.id,
          image: model.link,
          enName: model.enName ?? "",
          krName: model.krName ?? "",
          arName: model.arName ?? "",
        ));
      }

      return Right(brands);
    } catch (error, stackTrace) {
      return Left(errorParse(error, stackTrace));
    }
  }

  @override
  Future<Either<ErrorModel, List<GenericEntity>>> getAccounts() async {
    try {
      final data = await accountsDataSource.getAccounts();

      final List<GenericEntity> accounts = [];

      for (GenericModel model in data ?? []) {
        accounts.add(GenericEntity(
          id: model.id,
          image: model.link,
          enName: model.enName ?? "",
          krName: model.krName ?? "",
          arName: model.arName ?? "",
        ));
      }

      return Right(accounts);
    } catch (error, stackTrace) {
      return Left(errorParse(error, stackTrace));
    }
  }

  @override
  Future<Either<ErrorModel, List<ProductEntity>>> getNewProducts() async {
    try {
      final result = await homeDataSource.getNewProducts();

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
          enName: model.enName ?? "",
          krName: model.krName ?? "",
          arName: model.arName ?? "",
          krDiscription: model.krDescription ?? "",
          arDescription: model.arDescription ?? "",
          enDescription: model.enDescription ?? "",
          enShippingDetails: model.enShippingDetails ?? "",
          arShippingDetails: model.arShippingDetails ?? "",
          krShippingDetails: model.krShippingDetails ?? "",
          prices: model.priceLists ?? [],
          stringColors: model.colors ?? "",
          stringSizes: model.sizes ?? "",
          productImages: model.link,
          discountPercentage: model.discountPercentage,
        ));
      }

      return Right(products);
    } catch (e, stackTrace) {
      return Left(errorParse(e, stackTrace));
    }
  }
}
