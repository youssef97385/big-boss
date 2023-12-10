// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsResponseModel _$ProductsResponseModelFromJson(
        Map<String, dynamic> json) =>
    ProductsResponseModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['totalPages'] as int?,
      pageNumber: json['pageNumber'] as int?,
    );

Map<String, dynamic> _$ProductsResponseModelToJson(
        ProductsResponseModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'pageNumber': instance.pageNumber,
      'totalPages': instance.totalPages,
    };
