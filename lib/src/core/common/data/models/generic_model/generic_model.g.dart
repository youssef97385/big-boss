// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenericModel _$GenericModelFromJson(Map<String, dynamic> json) => GenericModel(
      id: json['id'] as int?,
      enName: json['en_Name'] as String?,
      arName: json['ar_Name'] as String?,
      krName: json['kR_Name'] as String?,
      remark: json['remark'] as String?,
      link: json['link'] as String?,
      subCategories: (json['subCategories'] as List<dynamic>?)
          ?.map((e) => GenericModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GenericModelToJson(GenericModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'en_Name': instance.enName,
      'ar_Name': instance.arName,
      'kR_Name': instance.krName,
      'remark': instance.remark,
      'link': instance.link,
      'subCategories': instance.subCategories,
    };
