import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/common/data/models/error_model/error_model.dart';


part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.successLogin() = _SuccessLogin;

  const factory LoginState.initial() = _Initial;

  const factory LoginState.loading() = _Loading;

  const factory LoginState.error({required ErrorModel errorModel}) = _Error;
}
