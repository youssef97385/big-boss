

import 'dart:developer';

import 'package:bigboss/src/features/shopping_cart/data/repository/cart_repository.dart';
import 'package:bigboss/src/features/shopping_cart/domain/entities/cart_item_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo cartRepo;

  CartCubit({required this.cartRepo}) : super(const CartState.initial());

  Future<void> getItems() async {
    emit(const CartState.loading());
    final items = await cartRepo.getItems() as List<CartItemEntity>;
    emit(CartState.cartItems(cartItems: items));
  }
  Future<void> addItemToCart({required CartItemEntity cartItem}) async {
    emit(const CartState.loading());
    final items = await cartRepo.addItem(cartItemEntity: cartItem);
    log("ITEMS ${items}");
    emit(CartState.cartItems(cartItems: items ));
  }

  Future<void> deleteItemFromCart({required CartItemEntity cartItem}) async {
    emit(const CartState.loading());
    final items = await cartRepo.removeItem(cartItemEntity: cartItem);
    emit(CartState.cartItems(cartItems: items));
  }

  Future<void> editItemCart({
    required CartItemEntity cartItem,
  }) async {
    emit(const CartState.loading());
    final items =await cartRepo.editItem(cartItemEntity: cartItem);
    emit(CartState.cartItems(cartItems: items));
  }

  Future<void> clearCart() async {
    emit(const CartState.loading());
    await Future.delayed(const Duration(seconds: 1));
    final items =await cartRepo.clearCart();
    emit(CartState.cartItems(cartItems: []));
  }
}
