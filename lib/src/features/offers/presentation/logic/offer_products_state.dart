
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../products_list/domain/entiities/product_endtity.dart';

part 'offer_products_state.freezed.dart';

@freezed
abstract class OfferProductsState with _$OfferProductsState {
  const factory OfferProductsState.initial() = _Initial;

  const factory OfferProductsState.loading() = _Loading;

  const factory OfferProductsState.error(String message) = _Error;

  const factory OfferProductsState.success(
      List<ProductEntity> products) = _Success;
}
