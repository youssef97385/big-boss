import 'package:bigboss/src/core/common/domain/entites/generic_entity.dart';
import 'package:bigboss/src/features/home_page/domain/entities/slide_entity.dart';
import 'package:bigboss/src/features/products_list/domain/entiities/product_endtity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'sub_category_state.freezed.dart';

@freezed
abstract class SubCategoryState with _$SubCategoryState {
  const factory SubCategoryState.initial() = _Initial;

  const factory SubCategoryState.loading() = _Loading;

  const factory SubCategoryState.error(String message) = _Error;

  const factory SubCategoryState.success(
      List<ProductEntity> accounts,int pageNumber,int totalPages) = _Success;
}
