// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slides_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SlidesResponseModel _$SlidesResponseModelFromJson(Map<String, dynamic> json) =>
    SlidesResponseModel(
      slides: (json['slides'] as List<dynamic>?)
          ?.map((e) => SlideModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SlidesResponseModelToJson(
        SlidesResponseModel instance) =>
    <String, dynamic>{
      'slides': instance.slides,
    };
