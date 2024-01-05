
import 'package:bigboss/src/features/products_list/domain/entiities/product_endtity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_details_state.freezed.dart';

@freezed
abstract class OrderDetailState with _$OrderDetailState {
  const factory OrderDetailState.initial() = _Initial;

  const factory OrderDetailState.loading() = _Loading;

  const factory OrderDetailState.error(String message) = _Error;

  const factory OrderDetailState.success(List<ProductEntity> products) = _Success;
}
