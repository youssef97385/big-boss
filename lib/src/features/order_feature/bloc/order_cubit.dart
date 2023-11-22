import 'package:bigboss/src/features/order_feature/data/order_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/common/data/models/error_model/error_model.dart';
import 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepo repo;

  OrderCubit({required this.repo}) : super(const OrderState.initial());

  Future<void> createOrder() async {
    emit(const OrderState.loading());
    final result = await repo.crateOrder({});
    emit(
      result.fold((ErrorModel error) {
        return OrderState.error(errorModel: error);
      }, (_) {
        return const OrderState.successOrder();
      }),
    );
  }
}
