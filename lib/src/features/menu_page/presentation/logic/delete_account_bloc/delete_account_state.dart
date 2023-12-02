import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/common/data/models/error_model/error_model.dart';


part 'delete_account_state.freezed.dart';

@freezed
class DeleteAccountState with _$DeleteAccountState {
  const factory DeleteAccountState.success() = _Success;

  const factory DeleteAccountState.initial() = _Initial;

  const factory DeleteAccountState.loading() = _Loading;

  const factory DeleteAccountState.error({required ErrorModel errorModel}) = _Error;
}
