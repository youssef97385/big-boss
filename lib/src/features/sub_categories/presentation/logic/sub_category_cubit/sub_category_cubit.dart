import 'package:bigboss/src/features/products_list/data/repository/products_repository.dart';
import 'package:bigboss/src/features/products_list/domain/entiities/product_endtity.dart';
import 'package:bigboss/src/features/products_list/presentation/logic/products_list_state.dart';
import 'package:bigboss/src/features/sub_categories/presentation/logic/sub_category_cubit/sub_category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/common/data/models/error_model/error_model.dart';

class SubCategoryCubit extends Cubit<SubCategoryState> {
  ProductRepository repository;

  SubCategoryCubit({required this.repository})
      : super(const SubCategoryState.initial());

  Future<void> getProductsBySubCategory({
    required int id,
    required int page,
  }) async {
    if (page == 1) {
      emit(const SubCategoryState.loading());
    }

    final result = await repository.getProductsBySubCategoryId(id, page);
    result.fold(
        (ErrorModel error) => emit(
              SubCategoryState.error(error.error ?? ""),
            ), (ProductsEntity productsEntity) {
      List<ProductEntity> list = [];
      if (page > 1) {
        state.maybeWhen(
            orElse: () {},
            success: (prods,page,total) {
              list = prods.toList();
              list.addAll(productsEntity.products ?? []);
              emit(SubCategoryState.success(list ?? [],
                  productsEntity.pageNumber??0, productsEntity.totalPages??0));
            });
        return;
      }
      emit(
        SubCategoryState.success(productsEntity.products ?? [],
            productsEntity.pageNumber ?? 0, productsEntity.totalPages ?? 0),
      );
    });
  }
}
