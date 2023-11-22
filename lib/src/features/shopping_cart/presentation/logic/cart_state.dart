import 'package:bigboss/src/features/shopping_cart/domain/entities/cart_item_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/common/data/models/error_model/error_model.dart';

part 'cart_state.freezed.dart';

@freezed
class CartState with _$CartState {
  const factory CartState.initial() = _Initial;

  const factory CartState.loading() = _Loading;

  const factory CartState.error({required ErrorModel errorModel}) = _Error;

  const factory CartState.cartItems({required List<CartItemEntity> cartItems}) =
      _CartItems;
}
