import 'package:bigboss/src/core/common/domain/entites/generic_entity.dart';
import 'package:bigboss/src/features/home_page/domain/entities/slide_entity.dart';
import 'package:bigboss/src/features/products_list/domain/entiities/product_endtity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'products_list_state.freezed.dart';

@freezed
abstract class ProductsListState with _$ProductsListState {
  const factory ProductsListState.initial() = _Initial;

  const factory ProductsListState.loading() = _Loading;

  const factory ProductsListState.error(String message) = _Error;

  const factory ProductsListState.success(
      List<ProductEntity> accounts) = _Success;
}
