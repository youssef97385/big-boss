import 'package:bigboss/src/core/common/data/models/error_model/error_model.dart';
import 'package:bigboss/src/core/common/domain/entites/generic_entity.dart';
import 'package:bigboss/src/features/home_page/domain/repository/home_repository.dart';
import 'package:bigboss/src/features/order_feature/data/order_repository.dart';
import 'package:bigboss/src/features/order_feature/modles/order_model.dart';
import 'package:bigboss/src/features/orders_page/presentation/bloc/orders_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersBloc extends Cubit<OrdersState> {
  OrderRepo repository;

  OrdersBloc({required this.repository}) : super(const OrdersState.initial()) {
    getOrders();
  }

  Future<void> getOrders() async {
    emit(const OrdersState.loading());

    final result = await repository.getAllOrders();
    result.fold(
      (ErrorModel error) => emit(
        OrdersState.error(error.message  ?? error.title??""),
      ),
      (List<OrderModel> orders) => emit(
        OrdersState.success(orders),
      ),
    );
  }
}
