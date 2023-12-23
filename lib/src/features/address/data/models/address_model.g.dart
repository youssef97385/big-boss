// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) => AddressModel(
      id: json['id'] as int?,
      remark: json['remark'] as String?,
      longitude: json['attitude'] as String?,
      latitude: json['latitude'] as String?,
    );

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attitude': instance.longitude,
      'latitude': instance.latitude,
      'remark': instance.remark,
    };
