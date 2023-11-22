// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) => LoginModel(
      token: json['token'] as String?,
      userId: json['userId'] as String?,
      isPhoneNumberConfirmed: json['isPhoneNumberConfirmed'] as bool?,
    );

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'userId': instance.userId,
      'isPhoneNumberConfirmed': instance.isPhoneNumberConfirmed,
    };
