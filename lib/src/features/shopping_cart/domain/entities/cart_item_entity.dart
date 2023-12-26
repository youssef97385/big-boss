import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'cart_item_entity.g.dart';

@HiveType(typeId: 5)
class CartItemEntity extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String image;
  @HiveField(3)
  final int count;
  @HiveField(4)
  final double price;
  @HiveField(5)
  final bool isOffer;

  const CartItemEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.count,
    required this.price,
    required this.isOffer,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        count,
        isOffer,
      ];
}
