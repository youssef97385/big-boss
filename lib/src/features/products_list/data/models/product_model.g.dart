// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'] as int?,
      link: (json['link'] as List<dynamic>?)?.map((e) => e as String).toList(),
      enName: json['en_Name'] as String?,
      arName: json['aR_Name'] as String?,
      krName: json['kR_Name'] as String?,
      enDescription: json['eN_Description'] as String?,
      arDescription: json['aR_Descritpion'] as String?,
      krDescription: json['kR_Description'] as String?,
      enShippingDetails: json['eN_ShippingDetails'] as String?,
      arShippingDetails: json['aR_ShippingDetails'] as String?,
      krShippingDetails: json['kR_ShippingDetails'] as String?,
      sizes: json['sizes'] as String?,
      colors: json['colors'] as String?,
      uoMs: json['uoMs'] as String?,
      weight: json['weight'] as String?,
      inStock: json['inStock'] as bool?,
      priceLists: (json['priceLists'] as List<dynamic>?)
          ?.map((e) => PriceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'en_Name': instance.enName,
      'aR_Name': instance.arName,
      'kR_Name': instance.krName,
      'eN_Description': instance.enDescription,
      'aR_Descritpion': instance.arDescription,
      'kR_Description': instance.krDescription,
      'eN_ShippingDetails': instance.enShippingDetails,
      'aR_ShippingDetails': instance.arShippingDetails,
      'kR_ShippingDetails': instance.krShippingDetails,
      'sizes': instance.sizes,
      'colors': instance.colors,
      'uoMs': instance.uoMs,
      'weight': instance.weight,
      'inStock': instance.inStock,
      'link': instance.link,
      'priceLists': instance.priceLists,
    };
