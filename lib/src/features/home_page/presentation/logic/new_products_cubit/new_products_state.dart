import 'package:bigboss/src/features/home_page/domain/entities/slide_entity.dart';
import 'package:bigboss/src/features/products_list/domain/entiities/product_endtity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'new_products_state.freezed.dart';

@freezed
abstract class NewProductsState with _$NewProductsState {
  const factory NewProductsState.initial() = _Initial;

  const factory NewProductsState.loading() = _Loading;

  const factory NewProductsState.error(String message) = _Error;

  const factory NewProductsState.success(List<ProductEntity> products) =
      _Success;
}
