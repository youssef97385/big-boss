import 'package:bigboss/src/features/products_list/data/repository/products_repository.dart';
import 'package:bigboss/src/features/products_list/domain/entiities/product_endtity.dart';
import 'package:bigboss/src/features/products_list/presentation/logic/products_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/data/models/error_model/error_model.dart';
import '../../data/models/products_categories_enum.dart';

class ProductsListCubit extends Cubit<ProductsListState> {
  ProductRepository repository;

  ProductsListCubit({required this.repository})
      : super(const ProductsListState.initial());

  Future<void> getProducts({
    required int id,
    required ProductCatsEnum productCatsEnum,
  }) async {
    emit(const ProductsListState.loading());

    final result = await repository.getProducts(productCatsEnum,id);
    result.fold(
      (ErrorModel error) => emit(
        ProductsListState.error(error.error ?? ""),
      ),
      (List<ProductEntity> products) => emit(
        ProductsListState.success(products),
      ),
    );
  }
}
