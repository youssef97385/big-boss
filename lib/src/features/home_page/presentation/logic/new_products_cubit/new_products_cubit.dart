import 'package:bigboss/src/features/home_page/domain/entities/slide_entity.dart';
import 'package:bigboss/src/features/home_page/domain/repository/home_repository.dart';
import 'package:bigboss/src/features/products_list/domain/entiities/product_endtity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/common/data/models/error_model/error_model.dart';
import 'new_products_state.dart';


class NewProductsCubit extends Cubit<NewProductsState> {
  HomeRepository repository;

  NewProductsCubit({required this.repository})
      : super(const NewProductsState.initial()){
    getSlides();
  }

  Future<void> getSlides() async {
    emit(const NewProductsState.loading());

    final result = await repository.getNewProducts(

    );
    result.fold(
          (ErrorModel error) => emit(
        NewProductsState.error(error.error ?? ""),
      ),
          (List<ProductEntity> products) => emit(
        NewProductsState.success(products),
      ),
    );
  }
}
