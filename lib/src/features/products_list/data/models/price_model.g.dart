// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceModel _$PriceModelFromJson(Map<String, dynamic> json) => PriceModel(
      id: json['id'] as int?,
      remark: json['remark'] as String?,
      fromQTY: json['fromQTY'] as int?,
      toQTY: json['toQTY'] as int?,
      price: (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PriceModelToJson(PriceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fromQTY': instance.fromQTY,
      'toQTY': instance.toQTY,
      'price': instance.price,
      'remark': instance.remark,
    };
