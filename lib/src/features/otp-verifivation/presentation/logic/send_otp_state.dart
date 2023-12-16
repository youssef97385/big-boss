import 'package:bigboss/src/features/otp-verifivation/data/models/send_otp_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/common/data/models/error_model/error_model.dart';


part 'send_otp_state.freezed.dart';

@freezed
class SendOtpState with _$SendOtpState {
  const factory SendOtpState.success(SendOtpResponseModel sendOtpResponseModel) = _Success;

  const factory SendOtpState.initial() = _Initial;

  const factory SendOtpState.loading() = _Loading;

  const factory SendOtpState.error({required ErrorModel errorModel}) = _Error;
}
