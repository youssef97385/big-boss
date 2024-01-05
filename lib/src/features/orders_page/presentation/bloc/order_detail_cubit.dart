import 'package:bigboss/src/core/common/data/models/error_model/error_model.dart';
import 'package:bigboss/src/features/order_feature/data/order_repository.dart';
import 'package:bigboss/src/features/products_list/domain/entiities/product_endtity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'order_details_state.dart';

class OrderDetailCubit extends Cubit<OrderDetailState> {
  OrderRepo repository;

  OrderDetailCubit({required this.repository}) : super(const OrderDetailState.initial()) ;

  Future<void> getOrder(int orderId) async {
    emit(const OrderDetailState.loading());

    final result = await repository.getOrderById(orderId);
    result.fold(
          (ErrorModel error) => emit(
        OrderDetailState.error(error.message  ?? error.title??""),
      ),
          (List<ProductEntity> products) => emit(
        OrderDetailState.success(products),
      ),
    );
  }
}
