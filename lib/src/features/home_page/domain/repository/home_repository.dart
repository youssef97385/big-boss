import 'package:bigboss/src/core/common/data/models/generic_model/generic_model.dart';
import 'package:bigboss/src/features/home_page/domain/entities/slide_entity.dart';
import 'package:bigboss/src/features/products_list/domain/entiities/product_endtity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/common/data/models/error_model/error_model.dart';
import '../../../../core/common/domain/entites/generic_entity.dart';


abstract class HomeRepository {
  Future<Either<ErrorModel, List<SlideEntity>>> getSlides();
  Future<Either<ErrorModel, List<GenericEntity>>> getBrands();
  Future<Either<ErrorModel, List<GenericEntity>>> getCategories();
  Future<Either<ErrorModel, List<GenericEntity>>> getCountries();
  Future<Either<ErrorModel, List<GenericEntity>>> getAccounts();
  Future<Either<ErrorModel, List<ProductEntity>>> getNewProducts();
}
