import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/common/data/models/error_model/error_model.dart';


part 'register_state.freezed.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState.successLogin() = _SuccessLogin;

  const factory RegisterState.initial() = _Initial;

  const factory RegisterState.loading() = _Loading;

  const factory RegisterState.error({required ErrorModel errorModel}) = _Error;
}
