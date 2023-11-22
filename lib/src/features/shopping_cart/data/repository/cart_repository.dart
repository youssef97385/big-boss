import 'package:bigboss/src/core/utils/managers/database/hive_service.dart';

import '../../../../core/constants/const.dart';
import '../../domain/entities/cart_item_entity.dart';

abstract class CartRepo {
  Future<dynamic> addItem({required CartItemEntity cartItemEntity});
  Future<dynamic> getItems();

  Future<dynamic> removeItem({required CartItemEntity cartItemEntity});

  Future<dynamic> editItem({
    required CartItemEntity cartItemEntity,
  });

  Future<dynamic> clearCart();
}

class CartRepoImpl implements CartRepo {
  final HiveService hiveService;

  CartRepoImpl({required this.hiveService});

  @override
  Future<dynamic> addItem({required CartItemEntity cartItemEntity}) async{
    await hiveService.addBox<CartItemEntity>(cartItemEntity.id.toString(), cartItemEntity, kCartKey);
    return await hiveService.getBoxes<CartItemEntity>(kCartKey) ;
  }

  @override
  Future<dynamic> clearCart() async {
    await  hiveService.clearBox<CartItemEntity>(kCartKey);
    return await hiveService.getBoxes<CartItemEntity>(kCartKey);
  }

  @override
  Future<dynamic> editItem({
    required CartItemEntity cartItemEntity,
  }) async{
    await hiveService.deleteBox(cartItemEntity.id.toString(), kCartKey);
    await  hiveService.addBox<CartItemEntity>(cartItemEntity.id.toString(), cartItemEntity, kCartKey);
    return await hiveService.getBoxes<CartItemEntity>(kCartKey);
  }

  @override
  Future<dynamic> removeItem({required CartItemEntity cartItemEntity}) async{
   await hiveService.deleteBox(cartItemEntity.id.toString(), kCartKey);
    return await hiveService.getBoxes<CartItemEntity>(kCartKey);
  }

  @override
  Future<dynamic> getItems() async{
    return await hiveService.getBoxes<CartItemEntity>(kCartKey);
  }
}
