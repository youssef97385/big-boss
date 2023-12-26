// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferModel _$OfferModelFromJson(Map<String, dynamic> json) => OfferModel(
      id: json['id'] as int?,
      enName: json['en_Name'] as String?,
      arName: json['aR_Name'] as String?,
      krName: json['kR_Name'] as String?,
      link: (json['link'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$OfferModelToJson(OfferModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'en_Name': instance.enName,
      'aR_Name': instance.arName,
      'kR_Name': instance.krName,
      'link': instance.link,
    };
