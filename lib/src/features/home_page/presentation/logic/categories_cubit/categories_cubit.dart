import 'package:bigboss/src/core/common/domain/entites/generic_entity.dart';
import 'package:bigboss/src/features/home_page/domain/repository/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/common/data/models/error_model/error_model.dart';
import 'categories_state.dart';



class CategoriesCubit extends Cubit<CategoriesState> {
  HomeRepository repository;

  CategoriesCubit({required this.repository})
      : super(const CategoriesState.initial()){
    getCategories();
  }

  Future<void> getCategories() async {
    emit(const CategoriesState.loading());

    final result = await repository.getCategories(

    );
    result.fold(
          (ErrorModel error) => emit(
        CategoriesState.error(error.error ?? ""),
      ),
          (List<GenericEntity> brands) => emit(
        CategoriesState.success(brands),
      ),
    );
  }
}
