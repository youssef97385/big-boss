// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartItemEntityAdapter extends TypeAdapter<CartItemEntity> {
  @override
  final int typeId = 5;

  @override
  CartItemEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartItemEntity(
      id: fields[0] as int,
      name: fields[1] as String,
      image: fields[2] as String,
      count: fields[3] as int,
      price: fields[4] as double,
      isOffer: fields[5] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, CartItemEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.count)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.isOffer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItemEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
