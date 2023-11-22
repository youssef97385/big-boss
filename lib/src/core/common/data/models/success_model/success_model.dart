import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'success_model.g.dart';

@JsonSerializable()
class SuccessModel extends Equatable {
  const SuccessModel({this.message, this.statusCode});

  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'status_code')
  final int? statusCode;

  factory SuccessModel.fromJson(Map<String, dynamic> json) =>
      _$SuccessModelFromJson(json);

  Map<String, dynamic> toJson() => _$SuccessModelToJson(this);

  @override
  List<Object?> get props => [
        message,
        statusCode,
      ];
}
