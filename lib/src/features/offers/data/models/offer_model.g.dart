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
      link: (json['link'] as List<dynamic>?)?.map((e) => e as String?).toList(),
      netTotal: (json['netTotal'] as num?)?.toDouble(),
      arDescritpion: json['aR_Descritpion'] as String?,
      krDescription: json['kR_Description'] as String?,
      enDescription: json['eN_Description'] as String?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
    )
      ..name = json['name'] as String?
      ..description = json['description'] as String?;

Map<String, dynamic> _$OfferModelToJson(OfferModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'en_Name': instance.enName,
      'aR_Name': instance.arName,
      'kR_Name': instance.krName,
      'eN_Description': instance.enDescription,
      'aR_Descritpion': instance.arDescritpion,
      'kR_Description': instance.krDescription,
      'link': instance.link,
      'netTotal': instance.netTotal,
      'name': instance.name,
      'description': instance.description,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
    };
