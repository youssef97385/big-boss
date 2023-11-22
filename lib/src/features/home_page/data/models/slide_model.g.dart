// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slide_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SlideModel _$SlideModelFromJson(Map<String, dynamic> json) => SlideModel(
      id: json['id'] as int?,
      link: json['link'] as String?,
      series: json['series'] as String?,
    );

Map<String, dynamic> _$SlideModelToJson(SlideModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'series': instance.series,
      'link': instance.link,
    };
