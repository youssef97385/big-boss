import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel extends Equatable {
  final String? token;
  final String? userId;
  final bool? isPhoneNumberConfirmed;

  const LoginModel({
    this.token,
    this.userId,
    this.isPhoneNumberConfirmed,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return _$LoginModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);

  @override
  List<Object?> get props => [
    token,
    userId,
    isPhoneNumberConfirmed,
  ];
}
