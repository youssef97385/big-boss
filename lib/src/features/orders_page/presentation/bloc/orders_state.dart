import 'package:bigboss/src/core/common/domain/entites/generic_entity.dart';
import 'package:bigboss/src/features/home_page/domain/entities/slide_entity.dart';
import 'package:bigboss/src/features/order_feature/modles/order_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'orders_state.freezed.dart';

@freezed
abstract class OrdersState with _$OrdersState {
  const factory OrdersState.initial() = _Initial;

  const factory OrdersState.loading() = _Loading;

  const factory OrdersState.error(String message) = _Error;

  const factory OrdersState.success(List<OrderModel> accounts) = _Success;
}
