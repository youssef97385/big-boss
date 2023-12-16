import 'package:bigboss/src/features/otp-verifivation/data/models/send_otp_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/common/data/models/error_model/error_model.dart';


part 'verify_phone_state.freezed.dart';

@freezed
class VerifyPhoneState with _$VerifyPhoneState {
  const factory VerifyPhoneState.success() = _Success;

  const factory VerifyPhoneState.initial() = _Initial;

  const factory VerifyPhoneState.loading() = _Loading;

  const factory VerifyPhoneState.error({required ErrorModel errorModel}) = _Error;
}
