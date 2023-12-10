import 'dart:developer';

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
    required int pageNumber,
  }) async {
    if (pageNumber == 1) {
      emit(const ProductsListState.loading());
    }

    final result = await repository.getProducts(
      productCatsEnum,
      id,
      pageNumber,
    );
    result.fold(
        (ErrorModel error) => emit(
              ProductsListState.error(error.error ?? ""),
            ), (ProductsEntity productsEntity) {
      List<ProductEntity> list = [];
      if (pageNumber > 1) {
        state.maybeWhen(
            orElse: () {},
            success: (prods, page, total) {
              list = prods.toList();
              list.addAll(productsEntity.products ?? []);
              emit(ProductsListState.success(
                  list ?? [],
                  productsEntity.pageNumber ?? 0,
                  productsEntity.totalPages ?? 0));
            });
        return;
      }
      emit(
        ProductsListState.success(productsEntity.products ?? [],
            productsEntity.pageNumber ?? 0, productsEntity.totalPages ?? 0),
      );
    });
  }
}
