import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/common/data/models/error_model/error_model.dart';



part 'order_state.freezed.dart';

@freezed
class OrderState with _$OrderState {
  const factory OrderState.successOrder() = _SuccessOrder;

  const factory OrderState.initial() = _Initial;

  const factory OrderState.loading() = _Loading;

  const factory OrderState.error({required ErrorModel errorModel}) = _Error;
}
