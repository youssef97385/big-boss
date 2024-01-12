// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      id: json['id'] as int?,
      dateTime: json['dateTime'] == null
          ? null
          : DateTime.parse(json['dateTime'] as String),
      netTotal: (json['netTotal'] as num?)?.toDouble(),
      orderStatus: json['orderStatus'] as int?,
      products: json['products'] == null
          ? null
          : OrderProductModel.fromJson(
              json['products'] as Map<String, dynamic>),
      qty: json['qty'] as int?,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dateTime': instance.dateTime?.toIso8601String(),
      'netTotal': instance.netTotal,
      'orderStatus': instance.orderStatus,
      'products': instance.products,
      'qty': instance.qty,
    };
