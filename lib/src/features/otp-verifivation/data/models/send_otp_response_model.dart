import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'send_otp_response_model.g.dart';

@JsonSerializable()
class SendOtpResponseModel extends Equatable {
  final String? message;


  const SendOtpResponseModel({
    this.message,
  });

  factory SendOtpResponseModel.fromJson(Map<String, dynamic> json) {
    return _$SendOtpResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SendOtpResponseModelToJson(this);

  @override
  List<Object?> get props => [
    message,

  ];
}
